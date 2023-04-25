#include "Bplus_Tree.h"
int MAX_KEYS = 11;

Node::Node()
{
	isLeaf = true;
	size = 0;
	key = new string[MAX_KEYS];
	ptr = new Node * [MAX_KEYS + 1];
}

BplusTree::BplusTree()
{
	root = nullptr;
}

bool BplusTree::Search(string category)
{
	if (root == nullptr)
		return false;

	else
	{
		Node* temp = root;
		while (temp->isLeaf == false)
		{
			for (int i = 0; i < temp->size; i++)
			{
				if (temp->key[i].compare(category) > 0)
				{
					if(temp->ptr[i] != nullptr)
						temp = temp->ptr[i];
					break;
				}
				if (i == temp->size - 1)
				{
					if (temp->ptr[i + 1] != nullptr)
						temp = temp->ptr[i + 1];
					break;
				}
			}
		}
		for (int i = 0; i < temp->size; i++)
		{
			if (temp->key[i] == category)
			{
				return true;
			}
		}
	}
	return false;
}

bool BplusTree::AddData(string category, string quote, string author)
{
	if (root == nullptr)
		return false;
	
	Node* temp = root;
	while (temp->isLeaf == false)
	{
		for (int i = 0; i < temp->size; i++)
		{
			if (temp->key[i].compare(category) < 0)
			{
				temp = temp->ptr[i];
				break;
			}
			if (i == temp->size - 1)
			{
				temp = temp->ptr[i + 1];
				break;
			}
		}
	}
	for (int i = 0; i < temp->size - 1; i++)
	{
		if (temp->key[i] == category)
		{
			//cout << " ---> Found Category\n";
			temp->quoteInfo.push_back(make_pair(quote, author));
			return true;
		}
	}
	return false;
}

vector<pair<string, string>> BplusTree::GetDataForCategory(string category)
{
	vector<pair<string, string>> result;
	if (root == nullptr)
		return result;
	Node* temp = root;
	while (temp->isLeaf == false)
	{
		for (int i = 0; i < temp->size; i++)
		{
			if (temp->key[i].compare(category) < 0)
			{
				temp = temp->ptr[i];
				break;
			}
			if (i == temp->size - 1)
			{
				temp = temp->ptr[i + 1];
				break;
			}
		}
	}
	for (int i = 0; i < temp->size; i++)
	{
		if (temp->key[i] == category)
		{
			cout << "\nFound Category\n";
			result = temp->quoteInfo;
		}
	}
	return result;

}

void BplusTree::Insert(string category)
{
	if (root == nullptr)
	{
		root = new Node();
		root->key[0] = category;
		root->isLeaf = true;
		root->size = 1;
	}

	else
	{
		Node* fast = root;
		Node* slow = nullptr;

		while (fast->isLeaf == false)
		{
			slow = fast;
			for (int i = 0; i < fast->size; i++)
			{
				if (fast->key[i].compare(category) < 0)
				{
					fast = fast->ptr[i];
					break;
				}
				if (i == fast->size - 1)
				{
					fast = fast->ptr[i + 1];
					break;
				}
			}
		}
		if (fast->size < MAX_KEYS)
		{
			int counter = 0;
			while (fast->key[counter].compare(category) < 0 && fast->size > counter)
				counter++;
			for (int i = fast->size; i > counter; i--)
			{
				fast->key[i] = fast->key[i - 1];
			}
			fast->key[counter] = category;
			fast->size++;
			fast->ptr[fast->size] = fast->ptr[fast->size - 1];
			fast->ptr[fast->size - 1] = nullptr;
		}

		else
		{
			Node* newLeaf = new Node();
			vector<string> tempKeys(MAX_KEYS + 1);
			for (int i = 0; i < MAX_KEYS; i++)
				tempKeys[i] = fast->key[i];

			int counter = 0;
			while (fast->key[counter].compare(category) < 0 && MAX_KEYS > counter)
				counter++;
			for (int i = MAX_KEYS; i > counter; i--)
				tempKeys[i] = tempKeys[i - 1];

			tempKeys[counter] = category;
			fast->size = (MAX_KEYS + 1) / 2;
			newLeaf->size = (MAX_KEYS + 1) - (MAX_KEYS + 1) / 2;
			fast->ptr[newLeaf->size] = fast->ptr[MAX_KEYS];
			fast->ptr[MAX_KEYS] = nullptr;

			for (int i = 0; i < fast->size; i++)
				fast->key[i] = tempKeys[i];

			for (int i = 0, j = fast->size; i < newLeaf->size; i++, j++)
				newLeaf->key[i] = tempKeys[j];

			if (fast == root)
			{
				Node* replacement = new Node();
				replacement->key[0] = newLeaf->key[0];
				replacement->ptr[0] = fast;
				replacement->ptr[1] = newLeaf;
				replacement->isLeaf = false;
				replacement->size = 1;
				root = replacement;
			}
			else
				InsertInternal(newLeaf->key[0], slow, newLeaf);
		}
	}
}

void BplusTree::InsertInternal(string category, Node* parent, Node* child)
{
	if (parent->size < MAX_KEYS)
	{
		int counter = 0;
		while (parent->key[counter].compare(category) < 0 && counter < parent->size)
			counter++;
		for (int i = parent->size; i > counter; i--)
			parent->key[i] = parent->key[i - 1];
		for (int i = parent->size + 1; i > counter + 1; i--)
			parent->ptr[i] = parent->ptr[i - 1];
		parent->key[counter] = category;
		parent->size++;
		parent->ptr[counter + 1] = child;
	}

	else
	{
		Node* newInternalNode = new Node;
		vector<Node*> ptrHolder(MAX_KEYS + 2);
		vector<string> tempKeys(MAX_KEYS + 1);

		for (int i = 0; i < MAX_KEYS; i++)
			tempKeys[i] = parent->key[i];

		for (int i = 0; i < MAX_KEYS + 1; i++)
			ptrHolder[i] = parent->ptr[i];

		int counter = 0;
		while (parent->key[counter].compare(category) < 0 && counter < parent->size)
			counter++;
		
		for (int i = MAX_KEYS; i > counter; i--)
			tempKeys[i] = tempKeys[i - 1];
		tempKeys[counter] = category;

		for (int i = MAX_KEYS + 1; i > counter; i--)
			ptrHolder[i] = ptrHolder[i - 1];
		ptrHolder[counter + 1] = child;
		
		newInternalNode->isLeaf = false;
		parent->size = (MAX_KEYS + 1) /2;
		newInternalNode->size = MAX_KEYS - (MAX_KEYS + 1)/2;

		for (int i = 0, j = parent->size; i < newInternalNode->size; i++, j++)
			newInternalNode->key[i] = tempKeys[j];

		for (int i = 0, j = parent->size + 1; i < newInternalNode->size + 1; i++, j++)
			newInternalNode->ptr[i] = ptrHolder[j];

		if (parent == root)
		{
			Node* replacement = new Node();
			replacement->key[0] = parent->key[parent->size];
			replacement->ptr[0] = parent;
			replacement->ptr[1] = newInternalNode;
			replacement->isLeaf = false;
			replacement->size = 1;
			root = replacement;
		}
		else
			InsertInternal(parent->key[parent->size], FindParent(root, parent), newInternalNode);
	}
}

Node* BplusTree::FindParent(Node* cursor, Node* child) {
	Node* parent = nullptr;
	if (cursor->isLeaf || (cursor->ptr[0])->isLeaf) {
		return NULL;
	}
	for (int i = 0; i < cursor->size + 1; i++) {
		if (cursor->ptr[i] == child) {
			parent = cursor;
			return parent;
		}
		else {
			parent = FindParent(cursor->ptr[i], child);
			if (parent != NULL)
				return parent;
		}
	}
	return parent;
}

void BplusTree::Display(Node* node) 
{
	if (node != nullptr) 
	{
		for (int i = 0; i < node->size; i++) 
			cout << node->key[i] << " ";
		cout << "\n";
		if (node->isLeaf != true)
			for (int i = 0; i < node->size + 1; i++)
				Display(node->ptr[i]);
	}
}
