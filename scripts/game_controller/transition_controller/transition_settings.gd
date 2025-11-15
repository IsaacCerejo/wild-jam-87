@icon("uid://7a2fopmj0du2")
extends Resource
class_name TransitionSettings

enum TRANSITION_TYPE {
	NONE,
	FADE_TO_FADE,
	SWIPE_TO_SWIPE,
}

## Type of transition effect to use.
@export var type: TRANSITION_TYPE = TRANSITION_TYPE.NONE
## Material used for the "out" transition effect.
@export var material_out: ShaderMaterial
## Material used for the "in" transition effect.
@export var material_in: ShaderMaterial
## Duration of the transition effect in seconds.
@export var duration: float = 1.0
## Easing function for the transition.
@export var easing: Tween.EaseType = Tween.EASE_IN_OUT
## Transition curve type.
@export var transition_type: Tween.TransitionType = Tween.TRANS_LINEAR
