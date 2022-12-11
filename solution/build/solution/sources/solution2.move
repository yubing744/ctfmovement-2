module solution::solution2 {
    use ctfmovement::hello_move;

    public entry fun init(account: &signer) {
        hello_move::init_challenge(account);
    }

    public entry fun get_flag(account: &signer) {
        hello_move::get_flag(account);
    }
}
