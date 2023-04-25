#include "CleanData.h"
#include "Bplus_Tree.h"

string OnlyAlphaNumeric(string rawData);
void PrintToOutput(vector<pair<string, string>> data, ofstream* printHere);

int main()
{
	ifstream input("cleaned_data\\Revised Quotes.txt");
	map<string, vector<pair<string, string>>> mapContainer;
	BplusTree treeContainer;

	if (!input.is_open())
	{
		cout << "Oh no!!\n";
		return -1;
	}

	cout << "*";
	int counter = 0;
	string data;
	while (getline(input, data, '_'))
	{
		string quote = data;
		getline(input, data, '_');
		string author = data;
		getline(input, data, '\n');

		int start = 0;
		while (true)
		{
			int end = data.find(' ', start);
			if (end != -1)
			{
				string category = OnlyAlphaNumeric(data.substr(start, end - start));
				/*if (!treeContainer.Search(category))
				{
					treeContainer.Insert(category);
					cout << category << ": #" << counter << "\n\n";
				}
				treeContainer.AddData(category, quote, author);*/
				mapContainer[category].push_back(make_pair(quote, author));
				start = end + 1;
			}
			else
				break;
		}

		//cout << "Current B+ Tree: " << endl;
		//treeContainer.Display();
		counter++;
		if (counter % 50000 == 0)
			cout << "Stored " << counter << " data points\n*";
		if (input.eof())
			break;
	}

	cout << "Finished storing data to structures after " << counter << " data points!\n";
	input.close();
	
	//Work with Frontend using input.txt and output.txt
	ofstream output;
	string oldAsk = "";
	while (true)
	{
		input.open("C:\\Program Files (x86)\\QuoteFinder\\windows-amd64\\data\\backend\\input.txt");

		if (input.is_open())
		{
			getline(input, data);
			int index = data.find(',');
			string structureName = data.substr(0, index);
			string category = data.substr(index + 1);
			category = OnlyAlphaNumeric(category);

			vector<pair<string, string>> printThis;
			if (/*structureName == "MAP" && */oldAsk != data)
			{
				printThis.clear();
				cout << "hit\n";
				if (mapContainer.find(category) != mapContainer.end())
				{
					cout << "Printing all data for category: " << category << endl;
					printThis = mapContainer[category];
				}
				else
				{
					cout << "Nothing found!!\n";
					printThis.push_back(make_pair("No information on category: ", category));
				}
			}

			if (data != oldAsk)
			{
				output.open("C:\\Program Files (x86)\\QuoteFinder\\windows-amd64\\data\\backend\\output.txt");
				PrintToOutput(printThis, &output);
				output.close();
				oldAsk = data;
			}
		}
		input.close();
	}
	return 0;
}

string OnlyAlphaNumeric(string rawData)
{
	string result = "";
	for (char test : rawData)
		//if (isdigit(test) || isalpha(test))
		if(test != '-')
			result += test;
	return result;
}

void PrintToOutput(vector<pair<string, string>> data, ofstream* printHere)
{
	cout << "Hi there\n";
	if (!printHere->is_open())
	{
		cout << "given invalid output file!!\n";
		return;
	}

	for (pair<string, string> info : data)
		*printHere << info.first << "_" << info.second << "\n";
}