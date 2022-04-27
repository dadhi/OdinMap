package main

import "core:fmt"

OMap :: struct($V: typeid) {
    hash: i32,
    value: V,
    left, right: ^OMap(V),
}

main :: proc() {

    m := OMap(string){1, "a", nil, nil}

    m.value = "b"

    fmt.printf("Hello map `%#v`", m)
    fmt.println()
    fmt.println("Hello Sailor!")
}