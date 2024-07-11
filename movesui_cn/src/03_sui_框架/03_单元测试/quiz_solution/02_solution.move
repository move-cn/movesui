#[test_only]
module my_package::math_tests {
    use my_package::math;

    #[test]
    fun test_add() {
        assert!(math::add(1, 2) == 3, 0);
    }
}