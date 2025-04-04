// #[allow(duplicate_alias,unused_variable,unused_use,unused_field,unused_function,unused_const,lint(self_transfer))]
// module cert_bank::cert_platform {

//     use sui::object;
//     use sui::tx_context;
//     use sui::transfer;
//     use std::vector;
//     use std::option;
//     use sui::table;
//     use std::string::{Self,String};


//     const E_NOT_SUPER_ADMIN:u64 = 25;
//     const E_ADMIN_NOT_FOUND:u64 = 28;
//     const E_ONLY_ADMIN_USER: u64 = 32;
//     const E_INST_NOT_FOUND: u64 = 29;
//     // Struct Definitions

//     // AdminCap
//     public struct AdminStruct has key {
//         id: UID,
        
//     }
//     public struct InstitutionRegistry has key, store {
//         id: UID,
//         institutions: vector<Institution>,
//         dt: u64
//     }

//     public struct Institution has key, store {
//         id: UID,
//         owner: address,
//         name: String,
//         active: bool,
//         dt: u64,
//     }

//     public struct InstCert has key, store {
//         id: UID,
//         owner: address,
//         instituition: address,
//         name: std::string::String,
//         active: bool,
//         dt: u64,
//     }

//     // create registry
//     fun create_registry(_: &AdminStruct,ctx: &mut TxContext):InstitutionRegistry{
//         let registry = InstitutionRegistry {
//             id: object::new(ctx),
//             institutions: vector::empty<Institution>(),
//             dt: tx_context::epoch_timestamp_ms(ctx),
//         };
//         registry
//     }

//     // add instituition (Only Admins)
//     public fun add_instituition(registry: &mut InstitutionRegistry, name: String ,ctx: &mut TxContext){
//         let inst = Institution{
//             id: object::new(ctx),
//             name: name,
//             owner: tx_context::sender(ctx),
//             dt: tx_context::epoch_timestamp_ms(ctx),
//             active: false 
//         };
//         vector::push_back(&mut registry.institutions, inst);
//     }

//     public fun get_instituition(registry: &InstitutionRegistry, inst_name: String): (bool,u64) {
//         // Check if you are the owner
//         let institutions = &registry.institutions;
//         let len = vector::length(institutions);
//         let mut i = 0;
//         while (i < len) {
//             let institution = vector::borrow(institutions, i);
//             if (&institution.name == inst_name) {
//                 (true,i);
//             };
//             i = i + 1;
//         };
//         (false,i)
//     }
    
//     public fun get_inst_by_id(registry: &InstitutionRegistry, inst_id: UID): (bool,u64) {
//         // Check if you are the owner
//         let institutions = &registry.institutions;
//         let len = vector::length(institutions);
//         let mut i = 0;
//         while (i < len) {
//         let inst_ref = vector::borrow(institutions, i);
//         if (inst_ref.id == inst_id) {
//             return (true,i)
//         };
//         i = i + 1 ;
//         }

//         (false,i);


//     }
    

    
    
//     public fun activate_institution(_: &AdminStruct, registry: &mut InstitutionRegistry,inst_name: String){
//         let (found,idx) = get_instituition(registry, inst_name);
//         assert!(found,E_INST_NOT_FOUND);
//         let inst = &mut registry.institutions[idx];
//         inst.active = true;
//     }

//     public fun issue_cert(registry: &mut InstitutionRegistry,name:String,inst_name:String,ctx: &mut TxContext){
//         let (found,idx) = get_instituition(registry, inst_name);
//         assert!(found,E_INST_NOT_FOUND);
//         let inst = &mut registry.institutions[idx];
//         let new_cert : InstCert = InstCert{
//             id: object::new(ctx),
//             name: name,
//             owner: tx_context::sender(ctx),
//             dt: tx_context::epoch_timestamp_ms(ctx),
//             active: false,
//             instituition: sui::object::id_address(inst)
//         };

//         // trnasfer
//         transfer::transfer(new_cert, tx_context::sender(ctx));


//     }

//     public fun activate_cert(_:&AdminStruct, registry: &mut InstitutionRegistry,name:String,inst_name:String,ctx: &mut TxContext){
//         let (found,idx) = get_instituition(registry, inst_name);
//         assert!(found,E_INST_NOT_FOUND);
//         let inst = &mut registry.institutions[idx];
//         let new_cert : InstCert = InstCert{
//             id: object::new(ctx),
//             name: name,
//             owner: tx_context::sender(ctx),
//             dt: tx_context::epoch_timestamp_ms(ctx),
//             active: false,
//             instituition: sui::object::id_address(inst)
//         };

//         // trnasfer
//         transfer::public_transfer(new_cert, tx_context::sender(ctx))

//     }

    



//     // Define the init function
//     fun init(ctx: &mut TxContext){
//         // Create admin struct and transfer to module publisher
//         let default_admin_struct: AdminStruct = AdminStruct{
//             id: object::new(ctx)
//         };
//         let registry = create_registry(&default_admin_struct, ctx);
//         transfer::transfer(default_admin_struct, tx_context::sender(ctx));
//         transfer::transfer(registry, tx_context::sender(ctx));
//     }


// }