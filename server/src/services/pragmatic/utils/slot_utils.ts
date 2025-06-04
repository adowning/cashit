//@ts-nocheck
export const max = (num1: number, num2: number): number => {
    return num1 > num2 ? num1 : num2;
}

export const min = (num1: number, num2: number): number => {
    return num1 < num2 ? num1 : num2;
}

export const maxInArr = (arr: number[]): { value: number, index: number } => {
    let max = arr[0];
    let maxIndex = 0;
    for (let i = 1; i < arr.length; i++) {
        if (max < arr[i]) {
            max = arr[i];
            maxIndex = i;
        }
    }
    let res = {
        value: max,
        index: maxIndex
    }
    return res;
}

export const minInArr = (arr: number[]): { value: number, index: number } => {
    let min = arr[0];
    let minIndex = 0;
    for (let i = 1; i < arr.length; i++) {
        if (min > arr[i]) {
            min = arr[i];
            minIndex = i;
        }
    }
    let res = {
        value: min,
        index: minIndex
    }
    return res;
}

export const random = (min: number, max: number): number => {
    let result = min + Math.floor(Math.random() * (max - min));
    return result;
}

export const randomMoney = (totalBet: number, max: number): number => {
    let div = Math.floor(max / totalBet);
    let mul = random(0, div);
    return totalBet * mul;
}

export const probability = (prob: number): boolean => {
    let n = Math.floor(Math.random() * 100);
    if (n < prob)
        return true;
    else
        return false;
}

export const shuffle = (arr: any[]): any[] => {
    if (arr.length <= 0) {
        return arr;
    }

    let a = 0;
    let b = 0;
    let tmp;
    for (let i = 0; i < arr.length; i++) {
        a = random(0, arr.length);
        b = random(0, arr.length);

        tmp = arr[a];
        arr[a] = arr[b];
        arr[b] = tmp;
    }

    return arr;
};

export const view2String = (view: any[]): string => {
    return view.join();
}

export const symbolsFromLine = (view: any[], payLine: number[]): any[] => {
    let result = [];

    for (let i = 0; i < payLine.length; i++) {
        let index = payLine[i];
        result[i] = view[index];
    }

    return result;
}

export const symbolCountFromView = (view: any[], symbol: any): number => {
    let result = 0;
    for (let i = 0; i < view.length; i++) {
        if (view[i] == symbol)
            result++;
    }
    return result;
}

export const clone = (arr: any[]): any[] => {
    let cloned = [];
    arr.forEach(
        (item) => {
            cloned.push(item);
        }
    );

    return cloned;
};

export const remove = (arr: any[], removeIndex: number): any[] => {
    let removed = [];
    for (let i = 0; i < arr.length; i++) {
        if (i == removeIndex)
            continue;
        removed.push(arr[i]);
    }
    return removed;
};

export const count = (arr: any[], element: any): number => {
    let count = 0;
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] == element) {
            count++;
        }
    }
    return count;
};

export const randomPositionArray = (w: number, h: number, c: number): number[] => {
    let result = [];
    for (let i = 0; i < w * h; i++) {
        result.push(i);
    }
    result = shuffle(result);
    return result.slice(0, c);
}

export const sameArray = (len: number, value: any): any[] => {
    let result = [];
    for (let i = 0; i < len; i++) {
        result.push(value);
    }
    return result;
}

export const positionsFromView = (view: any[], func: (item: any) => boolean): number[] => {
    let res = [];

    for (let i = 0; i < view.length; ++i) {
        if (func(view[i])) {
            res.push(i);
        }
    }

    return res;
}

export const getMaskView = (view: any[], max: number, func: (item: any) => boolean): any[] => {
    let res = [...view];

    for (let i = 0; i < view.length; ++i) {
        if (func(view[i])) {
            res[i] = random(3, max);
        }
    }

    return res;
}

export const Result4Client = (obj: { [key: string]: any }): string => {
    let str = "";
    for (let index in obj) {
        str += index + "=" + obj[index] + "&";
    }
    return str;
}

export const MIN_FACTOR = 0.8;
export const MAX_FACTOR = 1.2;
