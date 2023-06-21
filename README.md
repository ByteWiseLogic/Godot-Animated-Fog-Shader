# Godot-Animated-Fog-Shader
This is my first shader I made. It's designed to animated the fog volumes in Godot 4 in the following ways:
- Weather (Sandstorms, Snowstorms, Idk what else)
- Animated low hanging mist

The shader has the following parameters:
- `density`: Controls the density of the fog.
- `noise_scale`: Controls the "resolution" of the noise texture.
- `edge_fade`: Controls how much the fog dissipates near the edges of the fog shape.
- `height_falloff`: The rate by which the fog dissipates from top to bottom, as height increases in world space. Extremely obvious on the `world` fog shape. The higher the value, the sharper the transition and more it dissipates, the lower the value, the smoother the transition and the less it dissipates. A negative value will switch top to bottom, with bottom to top. A value of 0.0 has no effect.
- `flatness`: This has an effect, similar to `height_falloff`. It flattens the fog in a way, putting more emphasis, on the bottom half of the fog volume. I suggest playing around with this value, almost immediately.
- `noise_flow`: This is the direction the fog animates, relative to world space. I see `-z` as North, `z` as South, `x` as East, and `-x` as West. Using that for reference, if you want it to flow North, start adding on the `z` axis, or whatever direction you want it to go. If you want to me to change it relative to it's orientation, make in issue of it or anything you want or want changed. I'll see what I can do about it.
- `emission_as_albedo`: If `true`, the shader will use the `emission` color of as the `albedo`. If combined with `gradient_as_albedo`, it takes a different approach. It then uses the gradient, as color, and `emission_energy` as brightness.
- `gradient_as_albedo`: If `true`, the shader will use the `gradient_texture` as a color ramp. If combined with `emission_as_albedo`. It then uses the gradient, as color, and `emission_energy` as brightness.
- `albedo`: The color of the fog. It's only used when `gradient_as_albedo` and `emission_as_albedo` are both `false`
- `emission`: The glow color of the fog. It's only used when `emission_as_albedo` is `true`, and `gradient_as_albedo` is `false`.
- `emission_energy`: The glow strength of the fog.
- `gradient_texture`: Color ramp for the fog, only used when `gradient_as_albedo` is `true`.
- `density_texture`: The noise texture for the fog. Very important.
