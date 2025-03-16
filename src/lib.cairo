// /// Interface representing `HelloContract`.
// /// This interface allows modification and retrieval of the contract balance.
// #[starknet::interface]
// pub trait IHelloStarknet<TContractState> {
//     /// Increase contract balance.
//     fn increase_balance(ref self: TContractState, amount: felt252);
//     /// Retrieve contract balance.
//     fn get_balance(self: @TContractState) -> felt252;
// }

// /// Simple contract for managing balance.
// #[starknet::contract]
// mod HelloStarknet {
//     use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

//     #[storage]
//     struct Storage {
//         balance: felt252,
//     }

//     #[abi(embed_v0)]
//     impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {
//         fn increase_balance(ref self: ContractState, amount: felt252) {
//             assert(amount != 0, 'Amount cannot be 0');
//             self.balance.write(self.balance.read() + amount);
//         }

//         fn get_balance(self: @ContractState) -> felt252 {
//             self.balance.read()
//         }
//     }
// }

// Import necessary modules and traits
use starknet::ContractAddress;

// Export the counter contract module
mod test_session {
    use starknet::storage::StoragePointerWriteAccess;
    use starknet::storage::StoragePointerReadAccess;
    
    #[starknet::interface]
    trait ITestSession<ContractState> {
        fn increase_counter(ref self: ContractState, value: u128);
        fn decrease_counter(ref self: ContractState, value: u128);
        fn get_counter(self: @ContractState) -> u128;
    }
    
    #[starknet::contract]
    mod counter {
        use starknet::storage::StoragePointerWriteAccess;
        use starknet::storage::StoragePointerReadAccess;
        
        #[storage]
        struct Storage {
            counter: u128,
        }
        
        #[abi(embed_v0)]
        impl TestSession of super::ITestSession<ContractState> {
            fn increase_counter(ref self: ContractState, value: u128) {
                self.counter.write(self.counter.read() + value);
            }
            
            fn decrease_counter(ref self: ContractState, value: u128) {
                let current = self.counter.read();
                if current >= value {
                    self.counter.write(current - value);
                } else {
                    self.counter.write(0);
                }
            }
            
            fn get_counter(self: @ContractState) -> u128 {
                self.counter.read()
            }
        }
    }
}

// Export the HelloStarknet contract module
mod hello_starknet {
    use starknet::storage::StoragePointerWriteAccess;
    use starknet::storage::StoragePointerReadAccess;
    
    #[starknet::interface]
    pub trait IHelloStarknet<TContractState> {
        /// Increase contract balance.
        fn increase_balance(ref self: TContractState, amount: felt252);
        /// Retrieve contract balance.
        fn get_balance(self: @TContractState) -> felt252;
    }
    
    #[starknet::contract]
    mod HelloStarknet {
        use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
        
        #[storage]
        struct Storage {
            balance: felt252,
        }
        
        #[abi(embed_v0)]
        impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {
            fn increase_balance(ref self: ContractState, amount: felt252) {
                assert(amount != 0, 'Amount cannot be 0');
                self.balance.write(self.balance.read() + amount);
            }
            
            fn get_balance(self: @ContractState) -> felt252 {
                self.balance.read()
            }
        }
    }
}