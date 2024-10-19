import * as LitJsSdk from "@lit-protocol/lit-node-client-nodejs";
import { LitNetwork } from "@lit-protocol/constants";

class Lit {
   LitNodeClientNodeJs;
   chain;

   constructor(chain){
     this.chain = chain;
   }

   async connect() {
      global.litNodeClient = new LitJsSdk.LitNodeClientNodeJs({
        alertWhenUnauthorized: false,
        litNetwork: "datil-dev",
        debug: true,
      });

      this.litNodeClient = global.litNodeClient;
      await this.litNodeClient.connect();
   }
}

const chain = "ethereum";

let myLit = new Lit(chain);
await myLit.connect();