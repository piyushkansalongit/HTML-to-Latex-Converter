%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "node.h"
    #include "generator.h"
    extern int yyparse();
    extern FILE *yyin;
    extern FILE *yyout;
    extern int yylex();
    void yyerror();
    char *out_file;
    FILE *fp;
    struct ast_node* head;
    struct ast_node* root;
    int cur_ind=0;
    int flag=0;
    char *tag_val;
    char *attr_val;
    char *attr_name;
%}
%union
{
    char* str_val;
}

%token <str_val> beginStartTag finishTag finishSelfClosingTag beginEndTag 
%token <str_val> TAG RAWTEXT ATTRIBUTE ATTRIBUTE_ASSIGN ATTRIBUTE_VALUE 

%%

grammar:
    | startTag grammar      
    | rawtext grammar       
    | closingTag grammar 
    | selfClosingTag grammar 
    ;

startTag:
    | beginST tag fT{  
                        struct ast_node* a = new_node("TAG",tag_val);
                        add_child(head,a);
                        head=a;
                        if(flag==0){
                            root=a;
                            flag=1;
                        }  

                    }
    | beginST tag attribute attribute_assign attribute_value fT {
                        struct ast_node* a = new_node("TAG",tag_val);
                        add_child(head,a);
                        head=a;
                        a=new_node(attr_name,attr_val);
                        add_child(head,a);
                        if(flag==0){
                            root=a;
                            flag=1;
                        }
                    }
    | beginST tag attribute_assign attribute_value fT 
    ;

closingTag:
    | beginET tag fT{
                        head=head->parent;
                    }
    ;

selfClosingTag:
    | beginST tag fSCT {
                        struct ast_node* a = new_node("TAG",tag_val);
                        add_child(head,a);
                        head=a;
                        if(flag==0){
                            root=a;
                            flag=1;
                        }
                        head=head->parent;
                    }               
    | beginST tag attribute attribute_assign attribute_value fSCT {
                        struct ast_node* a = new_node("TAG",tag_val);
                        add_child(head,a);
                        head=a;
                        a=new_node(attr_name,attr_val);
                        add_child(head,a);
                        if(flag==0){
                            root=a;
                            flag=1;
                        }
                        head=head->parent;

                    }
    ;

rawtext: RAWTEXT    {  
                        struct ast_node* a = new_node("RAWTEXT",yylval.str_val);
                        add_child(head,a);
                    }
    ;

beginST: beginStartTag
    ;

beginET: beginEndTag
    ;

fT: finishTag
    ;
    
fSCT: finishSelfClosingTag 
    ;

tag: TAG {
    tag_val=yylval.str_val;
    }
    ;

attribute: ATTRIBUTE {
    attr_name = yylval.str_val;
    }
    ;

attribute_assign: ATTRIBUTE_ASSIGN
    ;

attribute_value: ATTRIBUTE_VALUE {
    attr_val = yylval.str_val;
    }
    ;

%%

void yyerror()
{
    fprintf(stderr, "Syntax error at line");
    exit(1);
}
void traverse(struct ast_node* a)
{
  printf("%s %s\n",a->type,a->val);
  for (int c=0;c<a->num_child;c++)
  {
    traverse(a->children[c]);
  }
  return ;
}
int main(){
    int flag;
    yyin = fopen("input.html", "r");
    yyparse();
    traverse(root);
    out_file = "output.tex";
    handle_table(root);
    handle_td(root);
    handle_a(root);
    post_order(root);
}



