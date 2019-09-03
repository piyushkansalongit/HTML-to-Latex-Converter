struct ast_node{
  char *type;
  char * val;
  char *front;
  char *end;
  struct ast_node *parent;
  int num_child;
  struct ast_node *children[50];
};


