<script setup lang="ts">
  import { onMounted, ref, nextTick } from 'vue'

  import { useGameStore } from '@/stores/game.store'
  import { useRouter } from 'vue-router'
  import logoPlaceholder from '@/assets/logo.png'
  import destr from 'destr'

  // import FlameEffectOverlay from './FlameEffectOverlay.vue'
  // import SnowEffectOverlay from './SnowEffectOverlay.vue'

  interface Game {
    id: number
    title: string
    developer: string
    name: string // Optional top banner text
    temperature: 'hot' | 'cold' | 'none' // Theme determines border color
    featured?: boolean
  }

  const router = useRouter()
  const gameStore = useGameStore()
  const games = ref<Game[]>(
    gameStore.gameSearchList.items.map((item: any) => ({
      id: Number(item.id),
      title: item.title,
      developer: item.developer, //item.developer ?? item.providerName ?? 'unknown',
      name: item.name,
      temperature: item.temperature ?? 'none',
      featured: item.featured ?? false,
    }))
  )
  const carousel = ref<HTMLElement | null>(null)

  // Lazy loading state
  const loadedImages = ref<Set<number>>(new Set())
  const imageLoadingStates = ref<Map<number, 'loading' | 'loaded' | 'error'>>(new Map())
  const imageDimensions = ref<Map<number, { width: number; height: number; aspectRatio: number }>>(
    new Map()
  )

  // Get image URL for a game
  const getGameImageUrl = (game: Game) => {
    return `https://images.cashflowcasino.com/${game.developer.toLowerCase()}/${game.name.toLowerCase()}.avif`
  }

  // Get smart background sizing based on image aspect ratio
  const getSmartBackgroundSize = (game: Game) => {
    const dimensions = imageDimensions.value.get(game.id)
    if (!dimensions) return 'auto 100%' // Default fallback

    const { aspectRatio } = dimensions
    // Mobile container aspect ratio: 145.19/239 = 0.608
    const containerAspectRatio = 0.608

    // Special handling for Red Tiger images (rtg.avif)
    const isRedTiger =
      game.developer.toLowerCase() === 'redtiger' || getGameImageUrl(game).includes('rtg.avif')

    if (isRedTiger) {
      // Red Tiger images are 440x440 (square), stretch to fill 145x240 container
      // console.log(
      //   `Red Tiger image detected for ${game.title} (${dimensions?.width}x${dimensions?.height}), stretching to 100% 100%`
      // )
      return '100% 100%'
    }

    if (aspectRatio > containerAspectRatio * 1.5) {
      // Very wide images: fit height, show full width
      return 'auto 100%'
    } else if (aspectRatio < containerAspectRatio * 0.7) {
      // Very tall images: fit width, show full height
      return '100% auto'
    } else if (aspectRatio > containerAspectRatio * 1.1) {
      // Moderately wide: fit height
      return 'auto 100%'
    } else {
      // Similar or tall aspect ratio: use cover
      return 'cover'
    }
  }

  // Get background image style with lazy loading and smart sizing
  const getBackgroundImageStyle = (game: Game) => {
    const isLoaded = loadedImages.value.has(game.id)
    const loadingState = imageLoadingStates.value.get(game.id)

    if (isLoaded && loadingState === 'loaded') {
      const backgroundSize = getSmartBackgroundSize(game)

      return `background-image: url('${getGameImageUrl(game)}'); background-size: ${backgroundSize};`
    } else {
      return `background-image: url('${logoPlaceholder}'); background-size: contain;`
    }
  }

  // Preload image and update state
  const preloadImage = (game: Game) => {
    if (loadedImages.value.has(game.id)) {
      console.log('Image already loaded for:', game.title)
      return
    }

    imageLoadingStates.value.set(game.id, 'loading')

    const img = new Image()
    const imageUrl = getGameImageUrl(game)

    img.onload = () => {
      // console.log(`Successfully loaded image for: ${game.title} (${img.width}x${img.height})`)

      // Store image dimensions and aspect ratio
      const aspectRatio = img.width / img.height
      imageDimensions.value.set(game.id, {
        width: img.width,
        height: img.height,
        aspectRatio: aspectRatio,
      })

      loadedImages.value.add(game.id)
      imageLoadingStates.value.set(game.id, 'loaded')
    }
    img.onerror = () => {
      console.warn(`Failed to load image for game: ${game.title} - URL: ${imageUrl}`)
      imageLoadingStates.value.set(game.id, 'error')
      // Keep placeholder image on error
    }
    img.src = imageUrl
  }

  const getScrollDistance = () => {
    // Calculate scroll distance based on screen size
    const screenWidth = window.innerWidth
    if (screenWidth <= 360) {
      // Very small mobile: 2 cards * 140px + gap
      return 2 * 140 + 10 + 10
    } else if (screenWidth <= 480) {
      // Small mobile: 2 cards * 160px + gap
      return 2 * 160 + 12 + 12
    } else if (screenWidth <= 768) {
      // Mobile: 2 cards * 180px + gap
      return 2 * 180 + 12 + 12
    } else {
      // Desktop: Default scroll distance
      return 200
    }
  }

  const scrollLeft = (distance?: number) => {
    if (carousel.value) {
      const scrollDistance = distance || getScrollDistance()
      carousel.value.scrollBy({
        left: -scrollDistance,
        behavior: 'smooth',
      })
    }
  }

  const scrollRight = (distance?: number) => {
    if (carousel.value) {
      const scrollDistance = distance || getScrollDistance()
      carousel.value.scrollBy({
        left: scrollDistance,
        behavior: 'smooth',
      })
    }
  }

  defineExpose({
    scrollLeft,
    scrollRight,
  })
  async function loadGame(game: any) {
    let token = localStorage.getItem('auth')
    token = destr(token).accessToken
    if (!token) {
      // console.error('No access token found. Cannot load game.')
      return
    }

    if (game.developer === 'netgame') {
      await router.push(`/netgame/?gameName=${game.name}&token=${token}`)
    } else if (game.developer === 'netent') {
      await router.push(`/netent/?gameName=${game.name}&token=${token}`)
    } else if (game.developer === 'nolimit') {
      await router.push(`/nolimit/?gameName=${game.name}&token=${token}`)
    } else if (game.developer === 'redtiger') {
      await router.push(`/redtiger/?gameName=${game.name}&token=${token}`)
    } else {
      console.warn(`Unsupported developer: ${game.developer}`)
    }
  }

  // Intersection Observer for lazy loading
  let intersectionObserver: IntersectionObserver | null = null

  const setupLazyLoading = () => {
    // Clean up existing observer
    if (intersectionObserver) {
      intersectionObserver.disconnect()
    }

    intersectionObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            const gameId = parseInt(entry.target.getAttribute('data-game-id') || '0')
            const game = games.value.find((g) => g.id === gameId)
            // console.log('Card in view:', gameId, game?.title) // Debug log
            if (game && !loadedImages.value.has(game.id)) {
              preloadImage(game)
              intersectionObserver?.unobserve(entry.target)
            }
          }
        })
      },
      {
        root: null, // Use viewport instead of carousel container
        rootMargin: '100px', // Start loading 100px before the card comes into view
        threshold: 0.1,
      }
    )

    // Observe all game cards with a delay to ensure DOM is ready
    setTimeout(() => {
      const gameCards = document.querySelectorAll('.game-card')
      // console.log('Setting up observers for', gameCards.length, 'cards') // Debug log
      gameCards.forEach((card) => {
        if (intersectionObserver) {
          intersectionObserver.observe(card)
        }
      })
    }, 100)
  }

  onMounted(() => {
    games.value = gameStore.gameSearchList.items.map((item: any) => ({
      id: item.id,
      title: item.title,
      developer: item.developer,
      name: item.name,
      temperature: item.temperature ?? 'none',
      featured: item.featured ?? false,
    }))
    // console.log('Games loaded:', games.value)

    // Setup lazy loading after games are loaded
    nextTick(() => {
      setupLazyLoading()
      // Preload first 2-4 images immediately for better initial experience
      const initialLoadCount = window.innerWidth <= 768 ? 2 : 4
      games.value.slice(0, initialLoadCount).forEach((game) => {
        preloadImage(game)
      })

      // Fallback: Add scroll listener to carousel for manual lazy loading
      if (carousel.value) {
        carousel.value.addEventListener('scroll', handleCarouselScroll)
      }
    })
  })

  // Fallback scroll handler for lazy loading
  const handleCarouselScroll = () => {
    if (!carousel.value) return

    const scrollLeft = carousel.value.scrollLeft
    const containerWidth = carousel.value.offsetWidth
    const scrollRight = scrollLeft + containerWidth

    // Load images for cards that are visible or about to be visible
    games.value.forEach((game, index) => {
      if (!loadedImages.value.has(game.id)) {
        const cardWidth = window.innerWidth <= 768 ? 180 : 200
        const gap = window.innerWidth <= 768 ? 15 : 15
        const cardPosition = index * (cardWidth + gap)

        // Load if card is within viewport + 200px buffer
        if (cardPosition >= scrollLeft - 400 && cardPosition <= scrollRight + 400) {
          preloadImage(game)
        }
      }
    })
  }

  // Fallback for broken images
  const onImageError = (event: Event) => {
    const target = event.target as HTMLImageElement
    target.src = 'https://placehold.co/300x400/64748b/ffffff?text=Image+Error'
    target.style.objectFit = 'contain'
  }
  // games.filter((game: Game) => {
  //   console.log(`https://images.cashflowcasino.com/${game.developer}/${game.name.toLowerCase()}.avif`)
  // })

  const isFeatured = (game: Game) => game.featured === true
</script>

<template>
  <div
    class="carousel-container bungee align-center relative flex flex-row items-center justify-center"
  >
    <!-- <img
        src="/images/filterbar/side-arrow-prev.avif "
        class="ml-1 flex size-12"
        style="text-align: center"
        @click="scrollBack"
      /> -->

    <div ref="carousel" class="carousel-scroll-area">
      <div class="carousel-track">
        <div
          v-for="game in games"
          :key="game.name"
          :data-game-id="game.id"
          class="game-card"
          :class="{
            'theme-cold': game.temperature === 'cold',
            'theme-hot': game.temperature === 'hot',
          }"
        >
          <div class="gradient-border"></div>

          <div
            class="card-content relative flex flex-col pt-5"
            :class="{ 'feat mt-3 flex-col align-bottom': isFeatured(game) }"
            :style="{
              backgroundImage: `url(${
                !isFeatured(game) ? '/images/games/tall-field.avif' : '/images/games/featured.webp'
              })`,
            }"
            style="background-size: 100% 100%; background-repeat: no-repeat"
            @click="loadGame(game)"
          >
            <div :class="isFeatured(game) ? 'card__banner_feat' : 'card__banner'" style="">
              <img
                v-if="game.temperature === 'cold'"
                src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/49240/hand-banner-blue.png"
                alt=""
                class="card__banner-img"
              />
              <img
                v-else-if="game.temperature === 'hot'"
                src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/49240/hand-banner-gold.png"
                alt=""
                class="card__banner-img"
              />
              <img
                v-else
                src="/images/games/hand-banner-black.png"
                alt=""
                class="card__banner-img"
              />
              <div
                class="card__banner__text Bronzier pt-1"
                style="line-height: 1.7; letter-spacing: 1.2px"
              >
                <span :style="game.title.length > 12 ? 'font-size: .8rem; ' : 'font-size: 1rem'">
                  {{ game.title.substring(0, 16) }}
                </span>
              </div>
            </div>

            <div
              :class="
                isFeatured(game) ? 'card-image-container-featured feat box' : 'card-image-container'
              "
              class="absolute top-0 overflow-hidden"
              style="z-index: 1"
            >
              <!-- <img
                :src="`https://images.cashflowcasino.com/${game.developer}/${game.name.toLowerCase()}.avif`"
                :alt="game.title"
                class="game-image absolute "
                style="z-index: 0; height: 70% ; width: 100%"
                @error="onImageError"
              /> -->
              <div
                class="game-image-container-with-filler absolute"
                style="
                  width: 92%;
                  top: 20px;
                  height: 240px;
                  max-height: 260px;
                  padding-top: 20px;
                  background: linear-gradient(
                    to bottom,
                    rgba(0, 0, 0, 0.1) 0%,
                    rgba(0, 0, 0, 0.05) 20%,
                    transparent 30%,
                    transparent 70%,
                    rgba(0, 0, 0, 0.05) 80%,
                    rgba(0, 0, 0, 0.1) 100%
                  );
                  border-radius: 15px;
                  border-top-left-radius: 30px;
                  border-top-right-radius: 30px;
                  overflow: hidden;
                "
              >
                <div
                  style="
                    width: 100%;
                    height: 100%;
                    background-position: center center;
                    background-repeat: no-repeat;
                    transition:
                      background-image 0.3s ease,
                      background-size 0.3s ease;
                  "
                  :style="getBackgroundImageStyle(game)"
                  :alt="game.title"
                  class="game-image absolute"
                  @error="onImageError"
                />
              </div>
              <!-- <SnowEffectOverlay
                class="absolute bottom-20"
                style="z-index: 2;  width: 30px; bottom: -30px; opacity: .8; height: 20%; "

                v-if="game.temperature === 'cold'"
              /> -->
              <!-- <FireEffectOverlay
                class="absolute bottom-20"
                style="z-index: 2;  width: 40px; bottom: -30px; opacity: .8; height: 30%; "
                v-if="game.temperature === 'hot'"
              />  -->
              <!-- <FlameEffectOverlay
                class="absolute bottom-20"
                style="z-index: 2;  width: 40px; bottom: -30px; opacity: .8; height: 30%; "
                v-if="game.temperature === 'hot'"
              /> -->
              <img
                v-if="game.temperature === 'cold'"
                src="/images/games/speedRTP_1.gif"
                height="40px"
                width="40px"
                style="position: absolute; bottom: 0; left: 0"
              />

              <img
                v-if="game.temperature === 'hot'"
                src="/images/games/speedRTP_5.gif"
                height="40px"
                width="40px"
                style="position: absolute; bottom: 0; left: 0"
              />

              <!-- </img> -->

              <div class="bottom-banner">
                {{ game.developer }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- <img
        src="/images/filterbar/side-arrow.avif "
        class="mx-1 flex size-12"
        style="text-align: center"
        @click="scrollForward"
      /> -->
  </div>
</template>

<style scoped>
  /* Your existing styles */

  .carousel-container {
    height: 42vh;
    min-height: 300px;
    max-height: 380px;
    width: 100%;
    max-width: 600px;
    margin: 0 0;
    margin-top: 10px;
    margin-bottom: 10px;
    position: relative;
    box-sizing: border-box;
  }

  .carousel-scroll-area {
    display: flex;
    overflow-x: auto;
    overflow-y: hidden;
    height: 100%;
    width: 100%;
    scrollbar-width: none;
    scroll-behavior: smooth;

    &::-webkit-scrollbar {
      height: 8px;
    }

    &::-webkit-scrollbar-track {
      background: rgba(0, 0, 0, 0.2);
      border-radius: 4px;
    }

    &::-webkit-scrollbar-thumb {
      background: linear-gradient(to right, #a855f7, #ec4899);
      border-radius: 4px;
      border: 1px solid rgba(0, 0, 0, 0.3);
    }

    &::-webkit-scrollbar-thumb:hover {
      background: linear-gradient(to right, #9333ea, #f472b6);
    }
  }

  .carousel-track {
    display: flex;
    gap: 12px;
    height: 100%;
    box-sizing: border-box;
    /* Desktop: Center content with padding */
    /* padding: 0 20px; */
  }
  /* Ensure the image container is relatively positioned and has a z-index */
  .card-image-container {
    height: 100%;
    flex-grow: 1;
    overflow: hidden;
    position: relative; /* Already present */
    border-radius: inherit;
    top: 0;
    z-index: 1;
  }
  .card-image-container-featured {
    height: 100%;
    flex-grow: 1;
    overflow: hidden;
    position: relative; /* Already present */
    border-radius: inherit;
    top: 20px;
    z-index: 1;
  }

  /* Game image container with filler */
  .game-image-container-with-filler {
    z-index: 0;
    display: block;
    margin-left: 8px;
    margin-right: 5px;
    border-color: white;
    border-width: 1.5px;
    border-left-style: solid;
    border-right-style: solid;
    border-bottom-style: solid;
    border-top-style: none;
    transition: transform 0.3s ease;
    position: absolute;
  }

  /* Ensure the game image has a lower z-index than the effects */
  .game-image {
    z-index: 0; /* Set a lower z-index */
    display: block;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    object-fit: cover;
    transition: background-image 0.3s ease;
    position: absolute; /* Ensure position is not static for z-index to work */
  }

  /* Placeholder styling for lazy loading */
  .game-image[style*='logo.png'] {
    background-size: contain !important;
    background-position: center !important;
    opacity: 0.7;
    filter: grayscale(0.3);
  }

  /* Loading animation for placeholder */
  .game-image[style*='logo.png']::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    animation: shimmer 1.5s infinite;
  }

  @keyframes shimmer {
    0% {
      transform: translateX(-100%);
    }
    100% {
      transform: translateX(100%);
    }
  }
  /* Other styles remain the same */
  .box {
    height: 40vh;
    min-height: 300px;
    max-height: 450px;
    display: grid;
    place-content: center;
    color: white;
    text-shadow: 0 1px 0 #000;
    --border-angle: 0turn;
    --main-bg: conic-gradient(from var(--border-angle), #213, #112 5%, #112 60%, #213 95%);
    border: solid 2px transparent;
    border-top: 0px;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0px;
    border-top-left-radius: 0;
    border-top-right-radius: 0px;
    --gradient-border: conic-gradient(
      from var(--border-angle),
      transparent 25%,
      #08f,
      #f03 99%,
      transparent
    );
    background:
      var(--main-bg) padding-box,
      var(--gradient-border) border-box,
      var(--main-bg) border-box;
    background-position: center center;
    -webkit-animation: bg-spin 2.5s linear infinite;
    animation: bg-spin 2s linear infinite;
  }

  @-webkit-keyframes bg-spin {
    to {
      --border-angle: 1turn;
    }
  }

  @keyframes bg-spin {
    to {
      --border-angle: 1turn;
    }
  }

  .box:hover {
    -webkit-animation-play-state: paused;
    animation-play-state: paused;
  }

  @property --border-angle {
    syntax: '<angle>';
    inherits: true;
    initial-value: 0turn;
  }

  .game-card {
    flex-shrink: 0;
    /* Desktop sizing */
    width: 200px;
    min-width: 200px;
    max-width: 200px;
    max-height: 350px;
    height: 100%;
    border-radius: 15px;
    position: relative;
    overflow: hidden;
    cursor: pointer;
    transition: transform 0.2s ease-out;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
  }

  .card__banner {
    width: 100%;
    position: absolute;
    top: 5%;
    left: 51%;
    transform: translateX(-51.5%) scaleY(1.1);
    background: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/49240/hand-banner-gold.png') 0 0
      no-repeat;
    background-size: 100% 110%;
    z-index: 4;
  }

  .card__banner_feat {
    width: 100%;
    position: absolute;
    top: 9%;
    left: 51%;
    transform: translateX(-51.5%);
    background: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/49240/hand-banner-gold.png') 0 0
      no-repeat;
    background-size: 100% auto;
    z-index: 4;
  }

  .card__banner-img {
    /* Added class for banner images */
    display: block;
    width: 100%;
    height: auto;
  }

  .card__banner__text {
    width: 90%;
    position: absolute;
    flex-wrap: nowrap;
    top: -2px;
    font-weight: 800;
    left: 50%;
    padding-left: 7px;
    padding-right: 7px;
    transform: translate(-51%, 10%);
    z-index: 5;
    text-align: center;
    font-size: 16px;
    font-weight: 600;
    color: #ffffff;
    text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.7);
  }

  .gradient-border {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: inherit;
    padding: 4px;
    z-index: 1;
    background-clip: content-box, border-box;
    background-origin: border-box;
    -webkit-mask:
      linear-gradient(#fff 0 0) content-box,
      linear-gradient(#fff 0 0);
    mask:
      linear-gradient(#fff 0 0) content-box,
      linear-gradient(#fff 0 0);
    -webkit-mask-composite: xor;
    mask-composite: exclude;
  }

  .theme-cold .gradient-border {
    background-image: linear-gradient(135deg, #a855f7, #ec4899);
  }

  .theme-hot .gradient-border {
    background-image: linear-gradient(135deg, #f97316, #eab308);
  }

  .card-content {
    z-index: 2;
    width: 100%;
    height: 100%;
    max-height: 350px;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    border-radius: inherit;
    top: 0;
  }

  .card-content-image.feat {
    z-index: 2;
    width: 100%;
    height: 95%;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    border-radius: inherit;
    top: 0;
  }

  .card-image-container.feat {
    margin-top: 0px;
  }
  .card-image-container.feat.span {
    margin-left: 5px;
    margin-right: 5px;
  }

  .bottom-banner {
    position: absolute;
    left: 0;
    width: 100%;
    background-color: transparent;
    color: white;
    text-align: center;
    font-size: 0.9rem;
    font-weight: bold;
    padding: 8px 8px;
    text-transform: uppercase;
    z-index: 3; /* Ensure banner is above image (z-index: 2) but below highest z-index if any */
    box-sizing: border-box;
    bottom: 0;
    border-bottom-left-radius: inherit;
    border-bottom-right-radius: inherit;
  }

  /* Responsive Adjustments */
  @media (max-width: 768px) {
    .carousel-track {
      /* Mobile: Calculate padding to center 2 cards */
      /* Screen width - (2 cards * card width) - gap = remaining space */
      /* Remaining space / 2 = padding on each side */
      padding: 0 calc((100vw - (2 * 180px) - 15px) / 2);
      gap: 15px;
    }

    .game-card {
      /* Mobile: Fixed width for exactly 2 cards to fit */
      width: 180px;
      min-width: 180px;
      max-width: 180px;
    }

    .top-banner {
      font-size: 0.7rem;
    }

    .bottom-banner {
      font-size: 0.8rem;
      padding: 6px;
    }
  }

  @media (max-width: 480px) {
    .carousel-track {
      /* Small mobile: Adjust for smaller screens */
      padding: 0 calc((100vw - (2 * 160px) - 12px) / 2);
      gap: 12px;
    }

    .game-card {
      /* Small mobile: Smaller cards */
      width: 160px;
      min-width: 160px;
      max-width: 160px;
    }
  }

  @media (max-width: 360px) {
    .carousel-track {
      /* Very small mobile: Further adjustment */
      padding: 0 calc((100vw - (2 * 140px) - 10px) / 2);
      gap: 10px;
    }

    .game-card {
      /* Very small mobile: Even smaller cards */
      width: 140px;
      min-width: 140px;
      max-width: 140px;
    }
  }
</style>
