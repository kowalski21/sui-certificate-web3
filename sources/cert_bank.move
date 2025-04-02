
// Move Contract Implmentation for certificate validation and issuance
#[allow(duplicate_alias,unused_variable,unused_use,unused_field)]
module cert_bank::certificate_platform {
    use sui::object;
    use sui::tx_context;
    use sui::transfer;
    use std::vector;

    const E_NOT_SUPER_ADMIN:u64 = 5;
    const E_ADMIN_NOT_FOUND:u64 = 8;
    const E_ONLY_ADMIN_USER: u64 = 12;


    /// Institution Registry struct (Singleton)
    public struct InstitutionRegistry has key, store {
        id: UID,
        super_admins: vector<address>, // List of super admins
        admins: vector<address>,       // List of admins
        institutions: vector<Institution>
    }

    /// Institution struct
    public struct Institution has key, store {
        id: UID,
        owner: address,
        name: vector<u8>,
        active: bool
    }

    /// Initialize the registry with a super admin (Run Once)
    public entry fun initialize_registry(super_admin: address, ctx: &mut TxContext) {
        let registry = InstitutionRegistry {
            id: object::new(ctx),
            super_admins: vector::singleton(super_admin),
            admins: vector::empty<address>(),
            institutions: vector::empty<Institution>()
        };
        transfer::public_transfer(registry, super_admin);
    }

    /// Function to check if the sender is a super admin
    public fun is_super_admin(registry: &InstitutionRegistry, sender: address): bool {
        vector::contains(&registry.super_admins, &sender)
    }
        /// Function to check if the sender is an admin
    public fun is_admin(registry: &InstitutionRegistry, sender: address): bool {
        vector::contains(&registry.admins, &sender) || is_super_admin(registry, sender)
    }


        /// Add a new admin (Super Admin Only)
    public entry fun add_admin(registry: &mut InstitutionRegistry, new_admin: address, ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx);
        assert!(is_super_admin(registry, sender), E_NOT_SUPER_ADMIN);
        vector::push_back(&mut registry.admins, new_admin);
    }

        /// Remove an admin (Super Admin Only)
    public entry fun remove_admin(registry: &mut InstitutionRegistry, admin_address: address, ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx);
        assert!(is_super_admin(registry, sender), E_NOT_SUPER_ADMIN);
        
        let (has,index) = vector::index_of(&registry.admins, &admin_address);
        assert!(has,E_ADMIN_NOT_FOUND);
        
        vector::remove(&mut registry.admins, index);
    }

        /// Add a new super admin (Super Admin Only)
    public entry fun add_super_admin(registry: &mut InstitutionRegistry, new_super_admin: address, ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx);
        assert!(is_super_admin(registry, sender), E_ONLY_ADMIN_USER);
        vector::push_back(&mut registry.super_admins, new_super_admin);
    }

    /// Register an institution (Admins Only)
    public entry fun register_institution(
        registry: &mut InstitutionRegistry, 
        name: vector<u8>, 
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);
        assert!(is_admin(registry, sender), E_ONLY_ADMIN_USER);

        let inst = Institution {
            id: object::new(ctx),
            owner: sender,
            name,
            active: false
        };
        vector::push_back(&mut registry.institutions, inst);
    }

        /// Activate an institution (Admins Only)
    public entry fun activate_institution(
        registry: &mut InstitutionRegistry, 
        inst_index: u64, 
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);
        assert!(is_admin(registry, sender), E_ONLY_ADMIN_USER);

        let inst = &mut registry.institutions[inst_index];
        inst.active = true;
    }



    

}
