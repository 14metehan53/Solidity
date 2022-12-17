// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TododApp {

    struct TodoList {
        address person;
        string text;
        bool completed;
    }

    TodoList[] public todos;

    function createText(string calldata _text) external {
        todos.push(
            TodoList({
                person: msg.sender,
                text: _text,
                completed: false
            })
        );
    }

    function updateText(uint256 _index, string calldata _text) external findIndex(_index) {
        require(todos[_index].person == msg.sender, "You cannot edit someone else's post.");
        todos[_index].text = _text;
    }


    function getTodo(uint _index) external findIndex(_index) view returns(string memory, bool) {
        TodoList storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function tgCompleted(uint256 _index) external findIndex(_index) {
        todos[_index].completed = !todos[_index].completed;
    }


    modifier findIndex(uint _index) {
        require(todos.length > _index, "Not a valid Index");
        _;
    }

}