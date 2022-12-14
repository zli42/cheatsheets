# 区块链

区块链三元悖论:

* 去中心化
* 安全性
* 可扩展性

解决方案:

* Layer-1
  * 分片
  * 优化共识算法
* Layer-2
  * 侧链
  * 状态通道 (比特币闪电网络)
  * Plasma (以太坊等离子体)
  * Rollup
    * Optimistic Rollup: 智能合约在二级链中运行, 用户可以质疑和否定提交到主链的区块
    * ZK Rollup

----

* 硬分叉: 与之前的版本不兼容
* 软分叉: 向后兼容，升级后的节点仍可以与未升级的节点进行交互

----

流动性

在不导致市场资产价格急剧变化的情况下，在市场中买卖资产的能力。换言之，市场中一定要有活跃的交易活动，并且买卖价格不能相差太远。

检查流动性:

* 24小时交易量
* 订单深度
* 买卖差价

----

DoS攻击，或者说拒绝服务攻击，是一种用于破坏合法用户访问目标网络或网站资源的方法。

----

闪电贷 (无需抵押)

贷款和还款发生在同一区块, 如无法偿还贷款金额和利息, 该交易将在区块验证之前取消.

超额抵押贷款

----

AMM使用流动性资金池,改变传统买卖对手方,减少gas费

----

ERC20

```solidity
function name() public view returns (string)
function symbol() public view returns (string)
function decimals() public view returns (uint8)
function totalSupply() public view returns (uint256)
function balanceOf(address _owner) public view returns (uint256 balance)
function transfer(address _to, uint256 _value) public returns (bool success)
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
function approve(address _spender, uint256 _value) public returns (bool success)
function allowance(address _owner, address _spender) public view returns (uint256 remaining)
```

ERC721

```solidity
function balanceOf(address _owner) external view returns (uint256);
function ownerOf(uint256 _tokenId) external view returns (address);
function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
function approve(address _approved, uint256 _tokenId) external payable;
function setApprovalForAll(address _operator, bool _approved) external;
function getApproved(uint256 _tokenId) external view returns (address);
function isApprovedForAll(address _owner, address _operator) external view returns (bool);
```
