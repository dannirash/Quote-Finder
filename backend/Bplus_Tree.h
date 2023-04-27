#pragma once
#include <climits>
#include <iostream>
#include <vector>
using namespace std;

class Node
{
private:
	bool isLeaf;
	string* key;
	int size;
	Node** ptr;
	vector<pair<string, string>> quoteInfo;
	friend class BplusTree;

public:
	Node();
};

class BplusTree
{
	Node* root;
	void InsertInternal(string category, Node* parent, Node* child);
	Node* FindParent(Node* first, Node* second);

public:
	BplusTree();
	bool Search(string category);
	bool AddData(string category, string quote, string author);
	vector<pair<string, string>> GetDataForCategory(string category);
	void Insert(string category); 
	void Display(Node* cursor);
	Node* GetRoot() 
		{ return root;}
};

