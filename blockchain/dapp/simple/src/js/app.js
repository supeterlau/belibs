App = {
  web3Provider: null,
  contracts: {},
  account: "0x0",

  init: () => App.initWeb3(),

  initWeb3: () => {
    if (typeof web3 !== "undefined") {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      let endpoint = "http://localhost:7545";
      App.web3Provider = new Web3.providers.HttpProvider(endpoint);
      web3 = new Web3(App.web3Provider);
    }
    return App.initContract();
  },

  initContract: () => {
    $.getJSON("Election.json", (election) => {
      App.contracts.Election = TruffleContract(election);
      // connect provider, interact with contract
      App.contracts.Election.setProvider(App.web3Provider);
      return App.render();
    });
  },

  render: () => {
    let electionInstance;
    let loader = $("#loader");
    let content = $("#content");

    loader.show();
    content.hide();

    // Load account
    web3.eth.getCoinbase((err, account) => {
      if (err === null) {
        App.account = account;
        $("#accoutAddress").html("Your Account: " + account);
      }
    });

    // Load contract
    App.contracts.Election.deployed()
      .then((instance) => {
        electionInstance = instance;
        return electionInstance.candidatesCount();
      })
      .then((candidatesCount) => {
        let candidatesResults = $("#candidatesResults");
        candidatesResults.empty();

        let candidatesSelect = $("#candidatesSelect");
        candidatesSelect.empty();

        for (let i = 1; i <= candidatesCount; i++) {
          electionInstance.candidates(i).then((candidate) => {
            let id = candidate[0];
            let name = candidate[1];
            let voteCount = candidate[2];
            let candidateTemplate = `<tr><th>${id}</th><td>${name}</td><td>${voteCount}</td></tr>`;
            candidatesResults.append(candidateTemplate);
            // candidate option
            // var candidateOption = `<option value='${id}'>${name}</option>`;
            var candidateOption =
              "<option value='" + id + "'>" + name + "</option>";
            candidatesSelect.append(candidateOption);
          });
        }
        return electionInstance.voters(App.account);
        // loader.hide();
        // content.show();
      })
      .then((hasVoted) => {
        if (hasVoted) {
          $("form").hide();
        }
        loader.hide();
        content.show();
      })
      .catch((error) => console.warn(error));
  },
  castVote: function () {
    var candidateId = $("#candidatesSelect").val();
    App.contracts.Election.deployed()
      .then((instance) => {
        return instance.vote(candidateId, { from: App.account });
      })
      .then(() => {
        $("#content").hide();
        $("#loader").show();
      })
      .catch((err) => console.error(err));
  },
};

$(() => {
  // $(window).load(() => App.init());
  $(window).on("load", () => App.init());
});
