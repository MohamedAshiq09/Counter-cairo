#[starknet::interface]
trait ITestSession<ContractState> {
    fn increase_counter(ref self: ContractState, value: u128);
    fn decrease_counter(ref self: ContractState, value: u128);
    fn get_counter(self: @ContractState) -> u128;
}

#[starknet::contract]
mod test_session {
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