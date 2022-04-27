package main

import "core:fmt"

OMap :: struct($V: typeid) {
    hash: i32,
    value: V,
    left, right: ^OMap(V),
}

new_omap_leaf :: proc(key: i32, value: $V) -> OMap(V) {
    return OMap(V){key, value, nil, nil}
}

new_omap_tree :: proc(key: i32, value: $V, right, left: ^OMap(V)) -> OMap(V) {
    return OMap(V){key, value, left, right}
}

new_omap :: proc{new_omap_leaf, new_omap_tree}

main :: proc() {

    m := new_omap(1, "a")
    m.value = "b"
    fmt.printf("leaf: `%v`\n", m)

    m1 := new_omap(3, "c")
    m2 := new_omap(2, "b", &m, &m1)
    fmt.printf("tree: `%#v`\n", m2)

    fmt.println("Hello Sailor!")
}