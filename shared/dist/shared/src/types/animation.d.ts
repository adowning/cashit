export interface AnimationFrameData {
    filename: string;
    frame: {
        x: number;
        y: number;
        w: number;
        h: number;
    };
    rotated: boolean;
    trimmed: boolean;
    spriteSourceSize: {
        x: number;
        y: number;
        w: number;
        h: number;
    };
    sourceSize: {
        w: number;
        h: number;
    };
}
export interface SpriteData {
    frames: AnimationFrameData[];
    meta?: {
        app?: string;
        version?: string;
        image?: string;
        format?: string;
        size?: {
            w: number;
            h: number;
        };
        scale?: string;
    };
}
export interface AnimationConfig {
    name: string;
    spritesheetUrl: string;
    spriteDataUrl: string;
    fps?: number;
    loop?: boolean;
    width?: number;
    height?: number;
    onComplete?: () => void;
}
export interface AnimationControlPayload {
    name: string;
    action: 'play' | 'stop';
    options?: {
        loop?: boolean;
        fps?: number;
        onComplete?: () => void;
    };
}
export declare const ANIMATION_TYPE: {
    readonly NONE: 'none';
    readonly SUCCESS: 'success';
    readonly ERROR: 'error';
    readonly WARNING: 'warning';
    readonly INFO: 'info';
};
export type AnimationType = (typeof ANIMATION_TYPE)[keyof typeof ANIMATION_TYPE];
export interface AnimationData {
    name: string;
    path: string;
    type: AnimationType;
    description?: string;
    loop?: boolean;
    autoplay?: boolean;
    renderer?: 'svg' | 'canvas' | 'html';
    player?: 'lottie' | 'rive';
}
/**
 * This interface is likely intended for a Vue component that would
 * consume and display an animation based on AnimationData.
 */
export interface AnimationComponentProps extends AnimationData {
    show: boolean;
    onCompleted?: () => void;
    onLoaded?: () => void;
}
