export interface CoinOffer {
  id: number
  imageSrc: string
  imageAlt: string
  coins: string
  price: string
  bonus?: string
  isBestValue: boolean
  primaryBgClass: string // Tailwind class for background, e.g., 'from-purple-600 to-purple-800'
  borderColorClass: string // Tailwind class for border, e.g., 'border-purple-400'
  buttonText: string
  buttonBgClass: string // Tailwind class for button background
}

export interface IconProps {
  closePressed?: boolean
}
