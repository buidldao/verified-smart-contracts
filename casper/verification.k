requires "edsl.k"
requires "../lemmas.k"

module VERIFICATION
    imports EDSL
    imports LEMMAS

    rule N -Int N => 0

    rule 0 <=Int (X modInt Y) => true

    rule (X modInt Y) <Int Y  => true

    rule 2 ^%Int X pow256 => 2 ^Int X  requires 0 <=Int X andBool X <Int 256

    rule log2Int(X) => 0

    rule 0 <=Int 2 ^Int X => true

    rule 2 ^Int X <Int pow256 => true  requires X <Int 256

    rule ((X *Int Y) /Int Z) /Int Y => X /Int Z


    syntax Int ::= symkeccak ( Int ) [function, smtlib(smt_symkeccak)]
 // -------------------------------------------------------------------
    rule keccak(WS) => symkeccak(#asWord(WS))  requires notBool #isConcrete(WS)


    rule 0 <=Int X &Int Y => true  requires 0 <=Int X andBool X <Int pow256
                                    andBool 0 <=Int Y andBool Y <Int pow256

    rule X &Int Y <Int pow256 => true  requires 0 <=Int X andBool X <Int pow256
                                        andBool 0 <=Int Y andBool Y <Int pow256

    rule X modInt Y => X requires 0 <=Int X andBool X <Int Y

    rule A s<Word (B -Word C) => 0  requires 0 <=Int A andBool A <Int 2 ^Int 127
                                     andBool 0 <=Int B andBool B <Int 2 ^Int 127
                                     andBool 0 <=Int C andBool C <Int 2 ^Int 127 
                                     andBool B -Int C <=Int A

    rule (0 <=Int #blockhash(_, _, _, _)) => true

    rule (#blockhash(_, _, _, _) <Int pow256) => true


///////////////////////////////////////////////////////////////////////////////
// Macros
///////////////////////////////////////////////////////////////////////////////


    syntax Int ::= "#expectedBlockNumber" "(" Int "," Int ")"  [function]
 // ---------------------------------------------------------------------
    rule #expectedBlockNumber(EPOCH, EPOCHLEN) => EPOCH *Int EPOCHLEN -Int 1


    syntax Int ::= "#recommendedBlockHash" "(" List "," Int "," Int "," Int ")"  [function]
 // ---------------------------------------------------------------------------------------
    rule #recommendedBlockHash(HASHES, BLOCKNUM, EPOCH, EPOCHLEN)
        => #blockhash(HASHES, #expectedBlockNumber(EPOCH, EPOCHLEN), BLOCKNUM -Int 1, 0)  


///////////////////////////////////////////////////////////////////////////////
// Predicates
///////////////////////////////////////////////////////////////////////////////


    syntax Bool ::= "#notVoteBefore" "(" Int "," Int ")"  [function]
 // -----------------------------------------------------------------
    rule #notVoteBefore(VOTEBITS, VID)
        => (VOTEBITS &Int (2 ^Int (VID modInt 256))) ==Int 0  [macro]

endmodule