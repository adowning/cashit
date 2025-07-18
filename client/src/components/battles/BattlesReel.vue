<template>
  <div class="battles-reel">
    <div
      v-for="(item, index) in reel"
      v-bind:key="index"
      class="reel-element"
      v-bind:class="['element-' + item.color, { 'element-active': index === pos }]"
    >
      <div class="element-image">
        <IconItemBlue v-if="item.color === 'blue'" />
        <IconItemPurple v-else-if="item.color === 'purple'" />
        <IconItemGreen v-else-if="item.color === 'green'" />
        <IconItemRed v-else-if="item.color === 'red'" />
        <IconItemYellow v-else />
        <img v-bind:src="item.item.image" />
      </div>
      <div v-if="index === 60 && running === false" class="element-info">
        <span>{{ item.item.name }}</span>
        <div class="info-amount">
          <img src="@/assets/img/icons/coin.svg" alt="icon" />
          <div class="amount-value">
            <span>{{ battlesFormatValue(item.item.amountFixed).split('.')[0] }}</span
            >.{{ battlesFormatValue(item.item.amountFixed).split('.')[1] }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
  import IconItemBlue from '@/components/icons/IconItemBlue.vue'
  import IconItemPurple from '@/components/icons/IconItemPurple.vue'
  import IconItemGreen from '@/components/icons/IconItemGreen.vue'
  import IconItemRed from '@/components/icons/IconItemRed.vue'
  import IconItemYellow from '@/components/icons/IconItemYellow'

  // Props
  const props = defineProps(['reel', 'pos', 'running'])

  // Methods
  const battlesFormatValue = function (value) {
    return parseFloat(Math.floor(value / 10) / 100)
      .toFixed(2)
      .toString()
      .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
  }
</script>

<style scoped>
  .battles-reel {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .battles-reel .reel-element {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
    opacity: 0.25;
  }

  .battles-reel .reel-element:last-child {
    margin-bottom: 0;
  }

  .battles-reel .reel-element.element-active {
    opacity: 1;
  }

  .battles-reel .element-image {
    width: 105px;
    height: 105px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
  }

  .battles-game .element-image svg {
    flex-shrink: 0;
  }

  .battles-reel .element-image img {
    width: 105px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    transition: transform 0.3s ease;
  }

  .battles-reel .reel-element.element-active .element-image img {
    transform: translate(-50%, -50%) scale(1.2);
  }

  .battles-reel .element-info {
    max-width: calc(100% - 115px);
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-left: 10px;
  }

  .battles-reel .element-info span {
    width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    text-align: center;
    font-size: 15px;
    font-weight: 600;
    color: #5e768e;
  }

  .battles-reel .info-amount {
    display: flex;
    align-items: center;
    margin-top: 3px;
  }

  .battles-reel .info-amount img {
    width: 18px;
    height: 18px;
    margin-right: 8px;
  }

  .battles-reel .amount-value {
    font-size: 11px;
    font-weight: 600;
    color: #bbbfd0;
  }

  .battles-reel .amount-value span {
    font-size: 14px;
    font-weight: 800;
    color: #ffffff;
  }
</style>
