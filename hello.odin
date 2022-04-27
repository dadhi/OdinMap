package main

import "core:fmt"

OMap :: struct($V: typeid) {
    hash: i32,
    value: V,
}

OMapBranch :: struct($V: typeid) {
    using entry: OMap(V),
    left, right: ^OMap(V),
}

new_omap_leaf :: proc(key: i32, value: $V) -> OMap(V) {
    return OMap(V){key, value}
}

new_omap_bush :: proc(key: i32, value: $V, left, right: ^OMap(V)) -> OMapBranch(V) {
    return OMapBranch(V){new_omap_leaf(key, value), left, right}
}

new_omap_rtree :: proc(key: i32, value: $V, left: ^OMap(V), right: ^OMapBranch(V)) -> OMapBranch(V) {
    return OMapBranch(V){new_omap_leaf(key, value), left, cast(^OMap(V))right}
}

new_omap :: proc{new_omap_leaf, new_omap_bush, new_omap_rtree}

main :: proc() {

    m := new_omap(1, "a")
    m.value = "b"
    fmt.printf("leaf: %v\n", m)

    l1 := new_omap(3, "c")
    t1 := new_omap(2, "b", &m, &l1)
    fmt.printf("tree: %#v\n", t1)

    t2 := new_omap(2, "b", &m, &l1)
    t3 := new_omap(2, "b", &l1, &t2)
    fmt.printf("tree: %#v\n", t3)

    fmt.printf("recover tree right: %#v\n", (cast(^OMapBranch(string))t3.right)^)

    fmt.println("Hello Sailor!")
}