use hex_literal::hex;
use sha3::{Digest, Keccak256};


fn hash(data: &[u8]) -> [u8; 32] {
    let mut hasher = Keccak256::new();
    hasher.update(data);
    let result = hasher.finalize();
    let mut hash = [0; 32];
    hash.copy_from_slice(&result);
    hash
}

fn hack_hash() {
    for i1 in 32..=255 {
        for i2 in 0..=255 {
            for i3 in 0..=255 {
                for i4 in 0..=255 {
                    let mut data = [0; 8];
                    data[0] = i1;
                    data[1] = i2;
                    data[2] = i3;
                    data[3] = i4;

                    data[4] = 109;
                    data[5] = 111;
                    data[6] = 118;
                    data[7] = 101;

                    let result = hash(&data);
                    if result[..] == hex!("d9ad5396ce1ed307e8fb2a90de7fd01d888c02950ef6852fbc2191d2baf58e79")[..] {
                        println!("Found it! {}", i1);
                        println!("Found it! {}", i2);
                        println!("Found it! {}", i3);
                        println!("Found it! {}", i4);
                        return;
                    }
                }
            }

            println!("Round  {}/{}", i1, i2);
        }
    }
}

fn main() {
    hack_hash();
    println!("over!");
}
