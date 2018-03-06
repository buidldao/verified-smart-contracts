*2017-12-23*

# Formal Verification of Philip Daian's Vyper ERC20 Token Contract

We present a formal verification of Philip Daian's Vyper ERC20 token contract.

The [Vyper ERC20 token][src] is shipped as part of the official [Vyper] language compiler distribution.
Vyper, being developed by the Ethereum Foundation, is an experimental smart contract language with syntax similar to Python, designed with the goal of being a simpler and more secure alternative to Solidity.

The Vyper ERC20 token is successfully verified against the ERC20-EVM specification, implying its full conformance to the ERC20 standard.

**NOTE**: The Vyper language/compiler project [changed its name from Viper to Vyper](https://github.com/ethereum/vyper/issues/501) after we had verified the token contract. The legacy name Viper is used when necessary throughout this document and the files in the current directory.

## Target Smart Contract

The target contract of our formal verification is the following, where we took the Vyper source code from the Vyper Github repository, https://github.com/ethereum/vyper, commit [`bf6ed1bf`][version]:

* [ERC20.v.py][src]

We formally verified the full functional correctness of the following ERC20 functions:

* [`totalSupply`](https://github.com/ethereum/vyper/blob/bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2/examples/tokens/ERC20_solidity_compatible/ERC20.v.py#L43)
* [`balanceOf`](https://github.com/ethereum/vyper/blob/bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2/examples/tokens/ERC20_solidity_compatible/ERC20.v.py#L48)
* [`allowance`](https://github.com/ethereum/vyper/blob/bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2/examples/tokens/ERC20_solidity_compatible/ERC20.v.py#L83)
* [`approve`](https://github.com/ethereum/vyper/blob/bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2/examples/tokens/ERC20_solidity_compatible/ERC20.v.py#L74)
* [`transfer`](https://github.com/ethereum/vyper/blob/bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2/examples/tokens/ERC20_solidity_compatible/ERC20.v.py#L52)
* [`transferFrom`](https://github.com/ethereum/vyper/blob/bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2/examples/tokens/ERC20_solidity_compatible/ERC20.v.py#L62)

## Verification Artifacts

### Compiled EVM Bytecode

We compiled the [source code][src] down to the EVM bytecode using the official Vyper compiler with the version 0.0.2 (of the commit [`bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2`][version]). Specifically, the EVM bytecode is obtained by running the following command:
```
$ viper -f bytecode_runtime ERC20.v.py
```

The local copy of the contract is the following:

* [ERC20.v.py](ERC20.v.py)

The EVM (runtime) bytecode generated by the Vyper compiler is the following:

* [ERC20.v.bytes](ERC20.v.bytes)

The (annotated) EVM assembly disassembled from the bytecode is the following:

* [ERC20.v.evm](ERC20.v.evm)

### Mechanized Specifications and Proofs

We took the [ERC20-EVM] specification and instantiated it with the [program-specific parameters] shown below.

```
[pgm]
compiler: "Viper"
_balances: 0
_allowances: 1
_totalSupply: 2
code: "0x600035601c52740100000000000000000000000000000000000000006020526f7fffffffffffffffffffffffffffffff6040527fffffffffffffffffffffffffffffffff8000000000000000000000000000000060605274012a05f1fffffffffffffffffffffffffdabf41c006080527ffffffffffffffffffffffffed5fa0e000000000000000000000000000000000060a05263d0e30db06000511415610168573460008112585761014052336101605261016051600060c052602060c02001546101405161016051600060c052602060c020015401116101405115176100e657600080fd5b6101405161016051600060c052602060c02001540161016051600060c052602060c020015560025461014051600254011161014051151761012657600080fd5b610140516002540160025561014051610180526101605160007fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef6020610180a3005b632e1a7d4d6000511415610260576020600461014037341561018957600080fd5b33610160526101405161016051600060c052602060c020015410156101ad57600080fd5b6101405161016051600060c052602060c02001540361016051600060c052602060c02001556101405160025410156101e457600080fd5b61014051600254036002556000600060006000600160605161014051806040519013585780919012585702610160516000f161021f57600080fd5b61014051610180526000610160517fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef6020610180a3600160005260206000f3005b6318160ddd600051141561028657341561027957600080fd5b60025460005260206000f3005b6370a0823160005114156102cd57602060046101403734156102a757600080fd5b60043560205181101558575061014051600060c052602060c020015460005260206000f3005b63a9059cbb60005114156103e057604060046101403734156102ee57600080fd5b60043560205181101558575033610180526101605161018051600060c052602060c0200154101561031e57600080fd5b6101605161018051600060c052602060c02001540361018051600060c052602060c020015561014051600060c052602060c02001546101605161014051600060c052602060c0200154011161016051151761037857600080fd5b6101605161014051600060c052602060c02001540161014051600060c052602060c0200155610160516101a05261014051610180517fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef60206101a0a3600160005260206000f3005b6323b872dd6000511415610559576060600461014037341561040157600080fd5b600435602051811015585750602435602051811015585750336101a0526101a05161014051600160c052602060c0200160c052602060c02001546101c0526101805161014051600060c052602060c0200154101561045e57600080fd5b6101805161014051600060c052602060c02001540361014051600060c052602060c020015561016051600060c052602060c02001546101805161016051600060c052602060c020015401116101805115176104b857600080fd5b6101805161016051600060c052602060c02001540161016051600060c052602060c0200155610180516101c05110156104f057600080fd5b610180516101c051036101a05161014051600160c052602060c0200160c052602060c0200155610180516101e05261016051610140517fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef60206101e0a3600160005260206000f3005b63095ea7b360005114156105ef576040600461014037341561057a57600080fd5b6004356020518110155857503361018052610160516101405161018051600160c052602060c0200160c052602060c0200155610160516101a05261014051610180517f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b92560206101a0a3600160005260206000f3005b63dd62ed3e600051141561064f576040600461014037341561061057600080fd5b6004356020518110155857506024356020518110155857506101605161014051600160c052602060c0200160c052602060c020015460005260206000f3005b"
gasCap: 100000
```

The resulting specification is the following:

* [vyper-erc20-spec.ini](vyper-erc20-spec.ini)

The specification is written in [eDSL], a domain-specific language for EVM specifications, whose good understanding is required in order to understand any of our EVM-level specification well.  Refer to [resources] for background on our technology.  The above file provides the [eDSL] specification template parameters, the full K reachability logic specification being automatically derived from a specification template by instantiating it with the template parameters.

Run the following command in the root directory of this repository, and it will generate the full specification under the directory `specs/vyper-erc20`:

```
$ make vyper-erc20
```

Run the EVM verifier to prove that the specification is satisfied by (the compiled EVM bytecode of) the target functions.
See this [instruction] for more details of running the verifier.

<!--
#### Reproducing Proofs

To prove that the specification is satisfied by (the compiled EVM bytecode of) the target functions, run the EVM verifier as follows:

```
$ ./kevm prove tests/proofs/specs/vyper-erc20/<func>-spec.k
```

where `<func>` is the name of the ERC20 function to verify.

The above command essentially executes the following command:

```
$ kprove vyper-erc20-spec.k -m VERIFICATION --z3-executable -d /path/to/evm-semantics/.build/java
```

#### Installing the EVM Verifier

The EVM verifier is part of the [KEVM] project.  The following commands will successfully install it, provided that all of the dependencies are installed.

```
$ git clone git@github.com:kframework/evm-semantics.git
$ cd evm-semantics
$ make deps
$ make
```

For detailed instructions on installing and running the EVM verifier, see [KEVM]'s [Installing/Building](https://github.com/kframework/evm-semantics/blob/master/README.md#installingbuilding) and [Example Usage](https://github.com/kframework/evm-semantics/blob/master/README.md#example-usage) pages.
-->


## [Resources](/README.md#resources)

## [Disclaimer](/README.md#disclaimer)


[KEVM]: <https://github.com/kframework/evm-semantics>
[K-framework]: <http://www.kframework.org>
[reachability logic theorem prover]: <http://fsl.cs.illinois.edu/index.php/Semantics-Based_Program_Verifiers_for_All_Languages>
[resources]: </README.md#resources>
[eDSL]: </resources/edsl.md>
[program-specific parameters]: </resources/edsl-spec.md#program-specific-parameters>
[Vyper]: <https://github.com/ethereum/vyper>
[version]: <https://github.com/ethereum/vyper/tree/bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2>
[src]: <https://github.com/ethereum/vyper/blob/bf6ed1bfde2071ee2d5fdd6fbe1c09cf3bec44f2/examples/tokens/ERC20_solidity_compatible/ERC20.v.py>
[ERC20]: <https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md>
[ERC20 standard]: <https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md>
[ERC20-K]: <https://github.com/runtimeverification/erc20-semantics>
[ERC20-EVM]: </resources/erc20-evm.md>
[instruction]: </resources/instruction.md>