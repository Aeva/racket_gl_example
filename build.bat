clang++ ^
    -I "glad" ^
    -fuse-ld=lld ^
    backend/backend.cpp glad/glad.c ^
    -shared -o backend.dll