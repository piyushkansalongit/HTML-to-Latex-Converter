#pragma once
#include <string.h>
#include "nodeStruct.h"
#include "generator.h"
struct ast_node* new_node(char *t,char *v)
{
  struct ast_node *a=malloc(sizeof(struct ast_node));
  a->type=t;
  a->val=v;
  map(a,t,v);
  return a ;
}
void handle_table(struct ast_node* a)
{
  if(strcmp(a->val,"table")==0){
      int n = ((a->children[0])->children[0])->num_child;
      char *column = malloc(n*2+100);
      int j=0;
      for(int i=0;i<n-1;i++,j++){
        column[j]='|';
        j++;
        column[j]='c';
      }
      column[j]='|';
      column[j+1]='c';
      column[j+2]='|';
      column[j+3]='}';
      column[j+4]='\\';
      column[j+5]='h';
      column[j+6]='l'; 
      column[j+7]='i'; 
      column[j+8]='n';
      column[j+9]='e';
      column[j+10]='\0';
      a->front=malloc(50+2*n);
      char *x = malloc(100);
      strcpy(x,"\\begin{tabular}{");
      strcat(x,column);
      strcpy(a->front, x);
      free(x);
      free(column);
      return;
  }
  for(int c=0; c<a->num_child;c++){
      handle_table(a->children[c]);
    }
}
void handle_td(struct ast_node* a){
  if(strcmp(a->val, "tbody")==0){
    int rows = a->num_child;
    for(int i=0;i<rows;i++){
      int columns = (a->children[i])->num_child;
      for(int j=0; j<columns-1; j++){
        char *y = malloc(5);
        strcpy(y, " & ");
        ((a->children[i])->children[j])->end = malloc(10);
        strcpy(((a->children[i])->children[j])->end, y);
      }
    }
    return;
  }
  for(int c=0; c<a->num_child;c++){
      handle_td(a->children[c]);
  }
  return;
}
void handle_a(struct ast_node* a){
  if(strcmp(a->val,"a")==0){
    for(int p=0; p<a->num_child; p++){
      if(strcmp((a->children[p])->type, "href")==0){
          char* y = malloc(strlen("}")+1);
          strcpy(y, "}");
          a->end = malloc(2);
          strcpy(a->end,y);
          break;
      }
    }
    return;
  }
  for(int c=0; c<a->num_child; c++){
    handle_a(a->children[c]);
  }
}
void post_order(struct ast_node* a)
{
  fp = fopen(out_file,"a+");
  fseek(fp,0, SEEK_SET);
  fputs(a->front,fp);
  fclose(fp);
  for (int c=0;c<a->num_child;c++)
  {
    post_order(a->children[c]);
  }
  fp = fopen(out_file,"a+");
  fseek(fp,0, SEEK_END);
  fputs(a->end,fp);
  fclose(fp);
}
void add_child(struct ast_node* b,struct ast_node* a)
{
  if (b==NULL)
  b=malloc(sizeof(struct ast_node));
  b->children[(b->num_child)++]=a;
  a->parent=b;
  return ; 
}
