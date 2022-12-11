module solution::solution2 {
    use std::vector;

    use aptos_std::aptos_hash;
    use ctfmovement::hello_move;

    public entry fun init(account: &signer) {
        hello_move::init_challenge(account);
    }

    public fun check_hash(guess: vector<u8>): bool {
        let borrow_guess = &mut guess;
        assert!(vector::length(borrow_guess) == 4, 0);
        vector::push_back(borrow_guess, 109);
        vector::push_back(borrow_guess, 111);
        vector::push_back(borrow_guess, 118);
        vector::push_back(borrow_guess, 101);

        aptos_hash::keccak256(guess) == x"d9ad5396ce1ed307e8fb2a90de7fd01d888c02950ef6852fbc2191d2baf58e79"
    }

    fun hack_hash(account: &signer){
        let i1 = 0;
        let i2 = 0;
        let i3 = 0;
        let i4 = 0;

        let guess = vector::empty<u8>();
        vector::push_back(&mut guess, i1);
        vector::push_back(&mut guess, i2);
        vector::push_back(&mut guess, i3);
        vector::push_back(&mut guess, i4);
        
        assert!(check_hash(guess), 0x1001);

        let guess2 = vector::empty<u8>();
        vector::push_back(&mut guess2, i1);
        vector::push_back(&mut guess2, i2);
        vector::push_back(&mut guess2, i3);
        vector::push_back(&mut guess2, i4);

        hello_move::hash(account, guess2);
    }


    public fun pow(g: u128, x: u128, p: u128): u128 {
        let ans = 1;
        g = g % p;
        while (x != 0) {
            if ((x & 1) == 1) {
                ans = ((ans % p) * (g % p)) % p;
            };
            x = x >> 1;
            g = (g * g) % p;
        };
        ans
    }

    fun hack_pow(account: &signer) {
        let guess = pow(10549609011087404693, 18164541542389285005, 18446744073709551616);
        assert!(pow(10549609011087404693, guess, 18446744073709551616) == 18164541542389285005, 0x1002);

        hello_move::discrete_log(account, guess)
    }

    const Initialize_balance : u8 = 10;
    const Action_Add : u8 = 1;
    const Action_Dot : u8 = 2;
    const Action_Left_Move : u8 = 3;

    struct Holder has key, store, drop {
        balance: u8,
    }

    fun add(res: &mut Holder, choice: u8, number: u8): bool {
        assert!(number <= 5, 0);

        if (choice == 1) {
            res.balance = res.balance + number;
        } else if (choice == 2) {
            res.balance = res.balance * number;
        } else if (choice == 3) {
            res.balance = res.balance << number;
        };

        res.balance < Initialize_balance
    }

    public entry fun hack_add(account: &signer) {
        let res = Holder {
            balance: Initialize_balance,
        };

        add(&mut res, Action_Add, 2);
        add(&mut res, Action_Add, 4);
        add(&mut res, Action_Left_Move, 4);

        assert!(res.balance < Initialize_balance, 0x1003);

        hello_move::add(account, Action_Add, 2);
        hello_move::add(account, Action_Add, 4);
        hello_move::add(account, Action_Left_Move, 4);
    }

    public entry fun get_flag(account: &signer) {
        hack_add(account);
        hack_pow(account);
        hack_hash(account);
        
        hello_move::get_flag(account);
    }
}
