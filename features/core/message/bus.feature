Feature: Message Bus Feature
  As a Turbo-Fx user
  I can Publish and Subscribe to Messages
  So that I can decouple classes


  Scenario: Immutable Messages
    Given I have channel: "view", topic: "template" and kind: "rendered" Message model
    When  I try to add a "data" property
    And   I try to set the "channel" property to "cucumber"
    Then  the model will not have the "data" property
    And   the "channel" property value will not equal "cucumber"


  Scenario: Bus Subscription
    Given I have a Message Bus
    When  I subscribe to channel: "*", topic: "*" and kind: "*" messages
    And   I publish a channel: "data", topic: "person" and kind: "created" message
    And   I publish a channel: "notification", topic: "person" and kind: "added" message
    And   I publish a channel: "view", topic: "form" and kind: "cancelled" message
    And   I publish a channel: "view", topic: "template" and kind: "loaded" message
    And   I publish a channel: "view", topic: "template" and kind: "rendered" message
    Then  I will receive all bus messages


  Scenario Outline: Channel Subscription
    Given I have a Message Bus
    When  I subscribe to channel: "view", topic: "*" and kind: "*" messages
    And   I publish a channel: "<channel>", topic: "<topic>" and kind: "<kind>" message
    Then  I will receive all channel: "view" messages

    Examples:
      | channel      | topic    | kind      |
      | data         | person   | created   |
      | notification | person   | added     |
      | view         | form     | cancelled |
      | view         | template | loaded    |
      | view         | template | rendered  |


  Scenario Outline: Topic Subscription
    Given I have a Message Bus
    When  I subscribe to channel: "view", topic: "template" and kind: "*" messages
    And   I publish a channel: "<channel>", topic: "<topic>" and kind: "<kind>" message
    Then  I will receive all channel: "view" and topic: "template" messages

    Examples:
      | channel      | topic    | kind      |
      | data         | person   | created   |
      | notification | person   | added     |
      | view         | form     | cancelled |
      | view         | template | loaded    |
      | view         | template | rendered  |


  Scenario Outline: Kind Subscription
    Given I have a Message Bus
    When  I subscribe to channel: "view", topic: "template" and kind: "rendered" messages
    And   I publish a channel: "<channel>", topic: "<topic>" and kind: "<kind>" message
    Then  I will receive all channel: "view", topic: "template" and kind: "rendered" messages

    Examples:
      | channel      | topic    | kind      |
      | data         | person   | created   |
      | notification | person   | added     |
      | view         | form     | cancelled |
      | view         | template | loaded    |
      | view         | template | rendered  |
