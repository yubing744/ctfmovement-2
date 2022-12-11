
use num_bigint::BigUint;

fn pow(base: &BigUint, exponent: &BigUint, md: &BigUint) -> BigUint {
    base.modpow(exponent,&md)
}

fn depow(base: u128, md: u128, result: u128) -> BigUint {
    let base = BigUint::from(base);
    let md_new = BigUint::from(md);
    let result = BigUint::from(result);

    for exponent in 0..=md {
        let exponent = BigUint::from(exponent);

        if pow(&base, &exponent, &md_new) == result {
            return exponent;
        }
    }

    panic!("not found");
}

fn main() {
    // pow(10549609011087404693, guess, 18446744073709551616) == 18164541542389285005
    println!("cal...");
    let ret = depow(10549609011087404693, 18446744073709551616, 18164541542389285005);
    println!("output: {}", ret);
}
