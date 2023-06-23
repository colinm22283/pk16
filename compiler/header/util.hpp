#pragma once

template<typename A, typename B, typename C>
inline bool in_range(A value, B low, C high) noexcept { return value >= low && value <= high; }