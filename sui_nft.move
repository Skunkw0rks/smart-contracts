module sui_nft::sui_nft {

use sui::url::{Self, Url};
use std::string;
use sui::object::{Self, UID};
use sui::transfer;
use sui::tx_context::{Self, TxContext};

public struct NNFT has key, store {
    id: UID,
    title: string::String,
    desc: string::String,
    url: Url,
    freetext: string::String,
}

public entry fun mint(title: vector<u8>, desc: vector<u8>, url: vector<u8>, freetext: vector<u8>, ctx: &mut TxContext) {
    ///initialise the actual nft 
    let art = NNFT {
        id: object::new(ctx),
        title: string::utf8(title),
        desc: string::utf8(desc),
        url: url::new_unsafe_from_bytes(url),
        freetext: string::utf8(freetext),
    };
    /// mint the nft and send it to the contract caller
    let sender = tx_context::sender(ctx);
    transfer::public_transfer(art, sender);
}
    ///function allowing the owner to transfer it to a seperate address
public entry fun transfer(art: NNFT, recipient: address){
    transfer::transfer(art, recipient);
}

}

