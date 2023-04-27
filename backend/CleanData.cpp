#include <fstream>
#include <iostream>
#include <random>
#include <string>
#include <vector>
#include <map>
using namespace std;

string GetPiece(ifstream* input);
void CleanData();

void CleanData()
{
    ifstream input;
    ofstream output;
    input.open("quotes.csv");    
    
    string read;
    getline(input, read, '\n');
    std::cout << "Format: " << read << "\n\n*";
    
    int minimumReferences = 10;
    int index = 0;
    map<string, pair<string, vector<string>>> allInfo;
    map<string, int> categoryInfo;

    while (true)
    {
        string quote = GetPiece(&input);
        string author = GetPiece(&input);
        string temp;
        vector<string> categories;

        if (quote == "")
            break;


        allInfo[quote] = make_pair(author, categories);
        getline(input, temp, '\n');

        if (temp[0] == '"')
        {
            temp = temp.substr(1, temp.size() - 2);
            int start = 0;
            while (true)
            {
                int end = temp.find(',', start);
                if (end != -1)
                {
                    allInfo[quote].second.push_back(temp.substr(start, end - start));
                    if (categoryInfo.find(temp.substr(start, end - start)) == categoryInfo.end())
                        categoryInfo[temp.substr(start, end - start)] = 0;
                    else
                        categoryInfo[temp.substr(start, end - start)]++;
                }
                else
                {
                    if (categoryInfo.find(temp.substr(start)) == categoryInfo.end())
                        categoryInfo[temp.substr(start)] = 0;
                    else
                        categoryInfo[temp.substr(start)]++;
                    allInfo[quote].second.push_back(temp.substr(start));
                    break;
                }
                start = end + 2;
            }
        }

        else
        {
            allInfo[quote].second.push_back(temp);
            if (categoryInfo.find(temp) == categoryInfo.end())
                categoryInfo[temp] = 0;
            else
                categoryInfo[temp]++;
        }

        //-------For Testing reasons-------//
        /*int counter = 0;
        std::cout << index << "==> " << quote << "\nAuthor: " << author << "\ncategories: ";
        for (string element : allInfo[quote].second)
        {
            std::cout << element;
            if (counter + 1 < allInfo[quote].second.size())
                std::cout << ", ";
            else
                std::cout << "\n\n";
            counter++;
        }*/
        if (index % 50000 == 0)
            std::cout << "Index at " << index << "\n*";
        
        index++;
        if (index == 392170)
            break;
    }
    input.close();
    std::cout << "Finished reading input!\n\n";

    map<string, bool> allowedCategories;
    for (pair<string, int> count : categoryInfo)
        allowedCategories[count.first] = minimumReferences < count.second;

    int ticker = 0;
    output.open("cleaned_data\\Valid Categories.csv");
    output << "appearances, category\n";
    for (pair<string, bool> count : allowedCategories)
    {
        if (count.first != "" && count.first != " " && count.second)
        {
            //std::cout << categoryInfo[count.first] << "," << count.first << "\n";
            output << categoryInfo[count.first] << "," << count.first << "\n";
            ticker++;
        }
    }
    output.close();

    std::cout << "Minimum number of refernence to be \"Valid\": " << minimumReferences;
    std::cout << "\nNumber of valid Categories: " << ticker;

    output.open("cleaned_data\\Revised Quotes.txt");
    
    string demiliter = "_";
    output << "Quote" << demiliter << "Author" << demiliter << "Categories\n";
    ticker = 0;

    for (pair<string, pair<string, vector<string>>> dataPoint : allInfo)
    {
        vector <string> adjustedCategory;
        for (string category : dataPoint.second.second)
        {
            if (allowedCategories.find(category) != allowedCategories.end() && category != "" && category != " ")
                adjustedCategory.push_back(category);
        }

        if (!adjustedCategory.empty())
        {
            int temp = 0;
            while (true)
            {
                if (dataPoint.first[temp] == ' ' || dataPoint.first[temp] == '\t')
                    dataPoint.first = dataPoint.first.substr(++temp);
                else
                    break;
            }

            if (dataPoint.second.first == "")
                dataPoint.second.first = "Unknown author";

            output << dataPoint.first << demiliter << dataPoint.second.first << demiliter;
            for (string attribute : dataPoint.second.second)
                output << attribute << " ";
            ticker++;
        }
        output << "\n";
    }
    output.close();
    std::cout << "\nNumber of inserted data points: " << ticker;
    std::cout << "\nData formed by: Quote" << demiliter << "Author" << demiliter << "Categories\n";
}

string GetPiece(ifstream* input)
{
    char temp;
    input->get(temp);
    string read;

    if (temp == '"')
    {
        string holder = "";
        while (true)
        {
            getline(*input, read, '"');
            holder += read;
            input->get(temp);
            if (temp == ',')
                break;
            holder += temp;
        }
        read = holder;
    }

    else
    {
        getline(*input, read, ',');
        read = temp + read;
    }
    return read;
}
