import Cookies from 'js-cookie'
import { storageLocal } from '@pureadmin/utils'
export interface DataInfo<T> {
  /** token */
  accessToken: string
  /** `accessToken`的过期时间（时间戳） */
  expires: T
  /** 用于调用刷新accessToken的接口时所需的token */
  refreshToken: string
  /** 用户ID */
  id: number
  /** 头像 */
  avatar?: string
  /** 用户名 */
  username?: string
  /** 昵称 */
  nickname?: string
  /** 当前登录用户的角色 */
  roles?: Array<string>
  /** 当前登录用户的按钮级别权限 */
  permissions?: Array<string>
}

export const userKey = 'user-info'
export const TokenKey = 'authorized-token'
/**
 * 通过`multiple-tabs`是否在`cookie`中，判断用户是否已经登录系统，
 * 从而支持多标签页打开已经登录的系统后无需再登录。
 * 浏览器完全关闭后`multiple-tabs`将自动从`cookie`中销毁，
 * 再次打开浏览器需要重新登录系统
 * */
export const multipleTabsKey = 'multiple-tabs'

/** 获取`token` */
export function getToken(): DataInfo<number> {
  // 此处与`TokenKey`相同，此写法解决初始化时`Cookies`中不存在`TokenKey`报错
  return Cookies.get(TokenKey)
    ? JSON.parse(Cookies.get(TokenKey) as string)
    : storageLocal().getItem(userKey)
}

/**
 * @description 设置`token`以及一些必要信息并采用无感刷新`token`方案
 * 无感刷新：后端返回`accessToken`（访问接口使用的`token`）、`refreshToken`（用于调用刷新`accessToken`的接口时所需的`token`，`refreshToken`的过期时间（比如30天）应大于`accessToken`的过期时间（比如2小时））、`expires`（`accessToken`的过期时间）
 * 将`accessToken`、`expires`、`refreshToken`这三条信息放在key值为authorized-token的cookie里（过期自动销毁）
 * 将`avatar`、`username`、`nickname`、`roles`、`permissions`、`refreshToken`、`expires`这七条信息放在key值为`user-info`的localStorage里（利用`multipleTabsKey`当浏览器完全关闭后自动销毁）
 */
export function setToken(data: DataInfo<Date>) {
  let expires = 0
  const { accessToken, refreshToken } = data
  //   const {isRemembered, loginDay} = useUserStore(); // eslint-disable-line @typescript-eslint/no-unused-vars
  expires = new Date(data.expires).getTime() // 如果后端直接设置时间戳，将此处代码改为expires = data.expires，然后把上面的DataInfo<Date>改成DataInfo<number>即可
  const cookieString = JSON.stringify({ accessToken, expires, refreshToken })

  const cookieOptions =
    expires > 0
      ? {
          expires: (expires - Date.now()) / 86400000,
        }
      : undefined

  Cookies.set(TokenKey, cookieString, cookieOptions)

  Cookies.set(
    multipleTabsKey,
    'true'
    // isRemembered
    //   ? {
    //       expires: loginDay
    //     }
  )

  function setUserKey(
    // id: {
    //   id: number
    //   avatar: string
    //   username: string
    //   nickname: string
    //   roles: string[]
    //   permissions: string[]
    // },
    id: number,
    avatar: string,
    username: string,
    nickname: string,
    roles: string[],
    permissions: string[]
  ) {
    // Store ID logic would go here
    // useUserStoreOutside().SET_AVATAR(avatar)
    // useUserStoreOutside().SET_USERNAME(username)
    // useUserStoreOutside().SET_NICKNAME(nickname)
    // useUserStoreOutside().SET_ROLES(roles)
    // useUserStoreOutside().SET_PERMS(permissions)
    storageLocal().setItem(userKey, {
      id,
      refreshToken,
      expires,
      avatar,
      username,
      nickname,
      roles,
      permissions,
    })

    console.log('userKey', storageLocal().getItem(userKey))
  }

  if (data.username && data.roles) {
    const { username, roles } = data

    setUserKey(
      data?.id ?? 0,
      data?.avatar ?? '',
      username,
      data?.nickname ?? '',
      roles,
      data?.permissions ?? []
    )
  } else {
    const id = storageLocal().getItem<DataInfo<number>>(userKey)?.id ?? 0
    const avatar = storageLocal().getItem<DataInfo<number>>(userKey)?.avatar ?? ''
    const username = storageLocal().getItem<DataInfo<number>>(userKey)?.username ?? ''
    const nickname = storageLocal().getItem<DataInfo<number>>(userKey)?.nickname ?? ''
    const roles = storageLocal().getItem<DataInfo<number>>(userKey)?.roles ?? []
    const permissions = storageLocal().getItem<DataInfo<number>>(userKey)?.permissions ?? []
    setUserKey(id, avatar, username, nickname, roles, permissions)
  }
}

/** 删除`token`以及key值为`user-info`的localStorage信息 */
export function removeToken() {
  Cookies.remove(TokenKey)
  Cookies.remove(multipleTabsKey)
  storageLocal().removeItem(userKey)
}

/** 格式化token（jwt格式） */
export const formatToken = (token: string): string => {
  return 'Bearer ' + token
}

/** 是否有按钮级别的权限（根据登录接口返回的`permissions`字段进行判断）*/
function isString(value: unknown): value is string {
  return typeof value === 'string'
}

/** 是否有按钮级别的权限（根据登录接口返回的`permissions`字段进行判断）*/
export const hasPerms = (value: string | Array<string>): boolean => {
  if (!value) return false
  return isString(value)
}
