import * as LitJsSdk from "@lit-protocol/lit-node-client-nodejs";
import { LitNetwork } from "@lit-protocol/constants";

class Lit {
   litNodeClient;
   chain;

   constructor(chain){
     this.chain = chain;
   }

   async connect() {
      this.litNodeClient = new LitJsSdk.LitNodeClient({
        litNetwork: "datil-test",
      });
      await this.litNodeClient.connect();
   }
}

const chain = "ethereum";

let myLit = new Lit(chain);
await myLit.connect();