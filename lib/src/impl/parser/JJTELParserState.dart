//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  02:28:54 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class JJTELParserState {
  List<Node> _nodes;
  List<int> _marks;

  int _sp = 0;        // number of _nodes on stack
  int _mk = 0;        // current mark
  bool _node_created = false;

  JJTELParserState() {
    _nodes = new List();
    _marks = new List();
    _sp = 0;
    _mk = 0;
  }

  /* Determines whether the current node was actually closed and
     pushed.  This should only be called in the final user action of a
     node scope.  */
  bool nodeCreated() {
    return _node_created;
  }

  /* Call this to reinitialize the node stack.  It is called
     automatically by the parser's ReInit() method. */
  void reset() {
    _nodes.clear();
    _marks.clear();
    _sp = 0;
    _mk = 0;
  }

  /* Returns the root node of the AST.  It only makes sense to call
     this after a successful parse. */
  Node rootNode() {
    return _nodes[0];
  }

  /* Pushes a node on to the stack. */
  void pushNode(Node n) {
    _nodes.add(n);
    ++_sp;
  }

  Object _remove(List list, int idx) {
    var mk0 = list[idx];
    list.removeRange(idx, 1);
    return mk0;
  }

  /* Returns the node on the top of the stack, and remove it from the
     stack.  */
  Node popNode() {
    if (--_sp < _mk) {
      _mk = _remove(_marks, _marks.length-1);
    }
    return _remove(_nodes, _nodes.length-1);
  }

  /* Returns the node currently on the top of the stack. */
  Node peekNode() {
    return _nodes[_nodes.length-1];
  }

  /* Returns the number of children on the stack in the current node
     scope. */
  int nodeArity() {
    return _sp - _mk;
  }


  void clearNodeScope(Node n) {
    while (_sp > _mk) {
      popNode();
    }
    _mk = _remove(_marks, _marks.length-1);
  }


  void openNodeScope(Node n) {
    _marks.add(_mk);
    _mk = _sp;
    n.jjtOpen();
  }


  /* A definite node is constructed from a specified number of
     children.  That number of _nodes are popped from the stack and
     made the children of the definite node.  Then the definite node
     is pushed on to the stack. */
  void closeNodeScope(Node n, int num) {
    _mk = _remove(_marks, _marks.length-1);
    while (num-- > 0) {
      Node c = popNode();
      c.jjtSetParent(n);
      n.jjtAddChild(c, num);
    }
    n.jjtClose();
    pushNode(n);
    _node_created = true;
  }


  /* A conditional node is constructed if its condition is true.  All
     the _nodes that have been pushed since the node was opened are
     made children of the conditional node, which is then pushed
     on to the stack.  If the condition is false the node is not
     constructed and they are left on the stack. */
  void closeNodeScopeByCondition(Node n, bool condition) {
    if (condition) {
      int a = nodeArity();
      _mk = _remove(_marks, _marks.length-1);
      while (a-- > 0) {
        Node c = popNode();
        c.jjtSetParent(n);
        n.jjtAddChild(c, a);
      }
      n.jjtClose();
      pushNode(n);
      _node_created = true;
    } else {
      _mk = _remove(_marks, _marks.length-1);
      _node_created = false;
    }
  }
}
/* JavaCC - OriginalChecksum=70ac39f1e0e1eed7476e1dae2dfa25fa (do not edit this line) */
