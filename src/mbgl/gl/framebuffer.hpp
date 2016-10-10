#pragma once

#include <mbgl/gl/object.hpp>

#include <array>

namespace mbgl {
namespace gl {

class Framebuffer {
public:
    // Framebuffer(std::array<uint16_t, 2> size_, gl::UniqueFramebuffer framebuffer_)
    //     : size(size_), framebuffer(std::move(framebuffer_)) {
    // }

    std::array<uint16_t, 2> size;
    gl::UniqueFramebuffer framebuffer;
};

} // namespace gl
} // namespace mbgl
