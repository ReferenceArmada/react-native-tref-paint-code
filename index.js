import { requireNativeComponent, NativeModules } from 'react-native';

const TrefPaintCode = requireNativeComponent('TrefPaintCode', null);
const TrefPaintCodeHelper = NativeModules.TrefPaintCodeHelper
const TrefPaintCodeType = {
    FLOAT: 'float',
    STRING: 'string',
    RESIZING_BEHAVIOUR: 'resizingBehaviour',
    BOOL: 'boolean'
}

const TrefPaintCodeResizingBehaviour = {
    ASPECT_FIT: 'aspectFit',
    ASPECT_FILL: 'aspectFill',
    STRETCH: 'stretch',
    CENTER: 'center'
}

export {
    TrefPaintCode,
    TrefPaintCodeHelper,
    TrefPaintCodeType,
    TrefPaintCodeResizingBehaviour
};
