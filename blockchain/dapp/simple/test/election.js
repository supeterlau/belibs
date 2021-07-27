let Election = artifacts.require("./Election.sol");

contract("Election", async function (accounts) {
  let electionInstance;
  let logCount = async (instance, idx) => {
    let candidate = await instance.candidates(idx);
    console.log(`votes of candidate${idx}: `, candidate[2]);
    return candidate[2];
  };
  it("allows a voter to cast a vote", () =>
    Election.deployed()
      .then((instance) => {
        electionInstance = instance;
        candidateId = 1;
        return electionInstance.vote(candidateId, { from: accounts[0] });
      })
      .then((receipt) => {
        assert.equal(receipt.logs.length, 1, "an event was triggered");
        assert.equal(
          receipt.logs[0].event,
          "votedEvent",
          "the event type is correct"
        );
        assert.equal(
          receipt.logs[0].args._candidateId.toNumber(),
          candidateId,
          "the candidate id is correct"
        );
        return electionInstance.voters(accounts[0]);
      })
      .then((voted) => {
        assert(voted, "the voter was marked as voted");
        // 返回 候选人信息 candidate[2] 是 voteCount
        return electionInstance.candidates(candidateId);
      })
      .then((candidate) => {
        let voteCount = candidate[2];
        assert.equal(voteCount, 1, "increments the candidate's vote count");
      }));

  it("throws an exception for double voting", async () => {
    const instance = await Election.deployed();
    await logCount(instance, 1);
    await logCount(instance, 2);
    let voter = accounts[0];
    try {
      await instance.vote(1, { from: voter });
    } catch (error) {
      /* handle error */
      assert(
        error.message.indexOf("revert") >= 0,
        "error message must contain revert"
      );
    }
    let voteCount = await logCount(instance, 1);
    assert.equal(voteCount, 1);
  });
});
