# Insurance Eligibilty veryfing system for healthcare
This system was designed to verify when insurance policy is still valid or not, and since all document related to insurance was in blockchain, no one can modify it easily, untill consent is provided by the holder of document.

For this project, we were team of 3 member, I was writting DAPP  in solidity. and other 2 teammates were gathering functional requirement.

In order to take this to next level, we planned to utilize Decentralize Identity concept, similar to UPort, but we didn't got much success and we weren't allowed to spend much time, since this was only a POC.

Whenever someone will buy a policy from some company, then system will create a one contract against that policy, which will contain all basic information like validity of policy, condition involved, party involved, and other basic info. Each contract will be given one ID.

When document holder wants to use that policy, then they can provide that ID, system will verfiy that policy based on that ID, and inform hospital, whether policy cn utilized or not.

Document holder and issuer will be informed about expiration, and document holder can renew it if they want.  and if policy is utilized somewhere, then issuer will be informed accordingly.

In order deploy DAPP we utilized Azure Blockchain Workbench. 
