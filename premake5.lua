project "GLFW"
    kind "StaticLib"
    staticruntime "on"
    language "C"

    targetdir (bindir .. "/%{prj.name}")
    objdir (objectdir .. "/%{prj.name}")

    files
    {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/glfw_config.h",
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/vulkan.c",
        "src/window.c"
    }


    filter "system:macosx or system:ios"
        defines
        {
            "_GLFW_COCOA",
        }

        sysincludedirs
        {
            "%{IncludeDir.Glad}",
        }

    filter { "action:xcode*" }
        defines
        {
            "_GLFW_COCOA",
        }

        sysincludedirs
        {
            "%{IncludeDir.Glad}",
        }

        XCodeBuildSettings =
        {
            ["CLANG_WARN_BOOL_CONVERSION"] = "YES",
            ["CLANG_WARN_CONSTANT_CONVERSION"] = "YES",
            ["CLANG_WARN_EMPTY_BODY"] = "YES",
            ["CLANG_WARN_ENUM_CONVERSION"] = "YES",
            ["CLANG_WARN_INFINITE_RECURSION"] = "YES",
            ["CLANG_WARN_INT_CONVERSION"] = "YES",
            ["CLANG_WARN_SUSPICIOUS_MOVE"] = "YES",
            ["CLANG_WARN_UNREACHABLE_CODE"] = "YES",
            ["CLANG_WARN__DUPLICATE_METHOD_MATCH"] = "YES",
            ["GCC_WARN_UNDECLARED_SELECTOR"] = "YES",
            ["GCC_WARN_UNINITIALIZED_AUTOS"] = "YES",
            ["GCC_WARN_UNUSED_FUNCTION"] = "YES",
            ["ENABLE_STRICT_OBJC_MSGSEND"] = "YES",
            -- ["ENABLE_NS_ASSERTIONS"] = "NO",
            ["ENABLE_TESTABILITY"] = "YES",
            ["GCC_NO_COMMON_BLOCKS"] = "YES",
            ["GCC_WARN_64_TO_32_BIT_CONVERSION"] = "YES",
        }
        merge(XCodeBuildSettings, OS.XCodeBuildSettings)
        xcodebuildsettings (XCodeBuildSettings)

    filter "system:macosx or system:ios"
        files
        {
            "src/cocoa_init.m",
            "src/cocoa_joystick.m",
            "src/cocoa_monitor.m",
            "src/cocoa_time.c",
            "src/posix_thread.c",
            "src/cocoa_window.m",
            "src/egl_context.c",
            "src/nsgl_context.m",
            "src/osmesa_context.c"
        }

    filter "system:linux"
        pic "On"
        systemversion "latest"

        files
        {
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/xkb_unicode.c",
            "src/posix_time.c",
            "src/posix_thread.c",
            "src/glx_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c",
            "src/linux_joystick.c"
        }

        defines
        {
            "_GLFW_X11"
        }

    filter "system:windows"
        systemversion "latest"

        files
        {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wgl_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c"
        }

        defines
        {
            "_GLFW_WIN32",
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"
