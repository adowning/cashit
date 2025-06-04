import { CoinOffer } from './types'

export const MEGA_SALE_BANNER_CHEST_IMG_LEFT = 'https://picsum.photos/seed/banner_chest_left/100/80'
export const MEGA_SALE_BANNER_CHEST_IMG_RIGHT =
  'https://picsum.photos/seed/banner_chest_right/100/80'
export const MEGA_SALE_BANNER_COIN_IMG = '/images/games/coins_buyitem_1.png'

export const COIN_OFFERS: CoinOffer[] = [
  {
    id: 1,
    imageSrc: '/images/games/coins_buyitem_1.png',
    imageAlt: 'Small stack of gold coins',
    coins: '5,000 COINS',
    price: '$4.99',
    bonus: '+500 Bonus!',
    isBestValue: false,
    primaryBgClass: 'bg-gradient-to-br from-purple-600 via-purple-700 to-indigo-800',
    borderColorClass: 'border-purple-400',
    buttonText: 'GET NOW',
    buttonBgClass: 'bg-yellow-400 hover:bg-yellow-500',
  },
  {
    id: 2,
    imageSrc: '/images/games/coins_buyitem_3.png',
    imageAlt: 'Open treasure chest full of gold coins',
    coins: '25,000 COINS',
    price: '$19.99',
    bonus: '+5,000 Bonus!',
    isBestValue: true,
    primaryBgClass: 'bg-gradient-to-br from-purple-700 via-pink-600 to-purple-900',
    borderColorClass: 'border-pink-400',
    buttonText: 'GET NOW',
    buttonBgClass: 'bg-green-500 hover:bg-green-600',
  },
  {
    id: 3,
    imageSrc: '/images/games/coins_buyitem_2.png',
    imageAlt: 'Large stack of gold coins',
    coins: '10,000 COINS',
    price: '$9.99',
    bonus: '+1,500 Bonus!',
    isBestValue: false,
    primaryBgClass: 'bg-gradient-to-br from-indigo-600 via-purple-700 to-purple-800',
    borderColorClass: 'border-indigo-400',
    buttonText: 'GET NOW',
    buttonBgClass: 'bg-yellow-400 hover:bg-yellow-500',
  },
]
