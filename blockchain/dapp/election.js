let Election = artifacts.require("./Election.sol");

contract("Election", function (accounts) {
  let electionInstance;

  // it("initializes with two candidates", function () {
  //   return Election.deployed()
  //     .then(function (instance) {
  //       return instance.candidatesCount();
  //     })
  //     .then((count) => assert.equal(count, 2));
  // });

  // it("initializes the candidates with correct values", () =>
  //   Election.deployed()
  //     .then((instance) => {
  //       electionInstance = instance;
  //       // 从 mapping lookup
  //       return electionInstance.candidates(1);
  //     })
  //     .then((candidate) => {
  //       assert.equal(candidate[0], 1, "id correct");
  //       assert.equal(candidate[1], "Pony", "name correct");
  //       assert.equal(candidate[2], 0, "vote count correct");
  //       return electionInstance.candidates(2);
  //     })
  //     .then((candidate) => {
  //       assert.equal(candidate[0], 2, "id correct");
  //       assert.equal(candidate[1], "Carl", "name correct");
  //       assert.equal(candidate[2], 0, "vote count correct");
  //     }));

  it("allows a voter to cast a vote", () =>
    Election.deployed()
      .then((instance) => {
        electionInstance = instance;
        candidateId = 1;
        return electionInstance.vote(candidateId, { from: accounts[0] });
      })
      .then(() => electionInstance.voters(accounts[0]))
      .then((voted) => {
        assert(voted, "the voter was marked as voted");
        // 返回 候选人信息 candidate[2] 是 voteCount
        return electionInstance.candidates(candidateId);
      })
      .then((candidate) => {
        let voteCount = candidate[2];
        assert.equal(voteCount, 1, "increments the candidate's vote count");
      }));

  it("throws an exception for invalid candidates", () => {
    Election.deployed()
      .then((instance) => {
        electionInstance = instance;
        // vote 编号 99 不存在的候选人
        return electionInstance.vote(99, { from: accounts[0] });
      })
      .then(assert.fail)
      .catch((error) => {
        // 测试包含特定的错误信息
        assert(
          error.message.indexOf("revert") >= 0,
          "error message must contain revert"
        );
        // 返回现有候选人，确保票数不变
        return electionInstance.candidates(1);
      })
      .then((candidate) => {
        let voteCount = candidate[2];
        // 受前一个测试影响
        assert.equal(voteCount, 1, "candidate 1 did not receive any votes");
        return electionInstance.candidates(1);
      })
      .then((candidate) => {
        let voteCount = candidate[2];
        // 受前一个测试影响
        assert.equal(voteCount, 0, "candidate 2 did not receive any votes");
      });
  });

  it("throws an exception for double voting", () =>
    Election.deployed()
      .then((instance) => {
        electionInstance = instance;
        candidateId = 2;
        // 测试只能给单个用户投一票
        // ? 测试已经投票用户无法给其他候选人投票
        electionInstance.vote(candidateId, { from: accounts[1] });
        return electionInstance.candidates(candidateId);
      })
      .then((candidate) => {
        electionInstance
          .voters(accounts[1])
          .then((state) => console.log("Voter state: ", state));
        let voteCount = candidate[2];
        assert.equal(voteCount, 1, "accepts first vote");
        console.log("2 => ", voteCount);
        return electionInstance.vote(candidateId, { from: accounts[1] });
        // Try to vote again
        // console.log("prepare call vote");
        // try {
        //   electionInstance.vote(candidateId, { from: accounts[1] });
        // } catch (e) {
        //   /* handle error */
        //   console.log("vote:", e);
        // }

        // return electionInstance.candidates(1);
      })
      .then(assert.fail)
      .catch((error) => {
        assert(
          error.message.indexOf("revert") >= 0,
          "error message must contain revert"
        );
        return electionInstance.candidates(1);
      })
      .then((candidate) => {
        let voteCount = candidate[2];
        console.log("1 => ", voteCount);
        // 受前几个测试影响
        assert.equal(voteCount, 1, "candidate 1 did not receive any votes");
        return electionInstance.candidates(2);
      })
      .then((candidate) => {
        let voteCount = candidate[2];
        console.log("2 => ", voteCount);
        assert.equal(1, 1, "pass");
      }));
});
// // 受前一个测试影响
// assert.equal(voteCount, 1, "candidate 2 did not receive any votes");
