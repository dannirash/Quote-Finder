# Quote-Finder
An application to find Quotes

Team Members: Dany Rashwan, Robert Kilkenny, Jane Seo

![mainMenu](https://user-images.githubusercontent.com/61055337/234738135-e9098945-8e31-4611-bf47-10cde0ba14a4.png)

![searchMenu](https://user-images.githubusercontent.com/61055337/234738175-d09a6355-b4bd-448c-8eca-3951a2d59840.png)

![resultMenu](https://user-images.githubusercontent.com/61055337/234738188-3c217c21-dd7f-47dd-b893-fbaf5958ffff.png)

Problem: 
It is often difficult to find a relatable quote to a certain situation on the spot. We are often faced with this problem in storyboarding, workshopping, 
or just regular conversing. Also, sometimes when we want to quote a prominent figure, we could be faced with this problem and would need to search several websites
for a specific quote.

Motivation: 
One issue that stands out when brainstorming ideas is accessibility for certain words or tools. Therefore, our motivation for this application is to ease the access
of quotes and make the process of brainstorming more fluid. The application will use adjectives to pair quotes from famous people or works of art to inspire the user.
The database used will be tailored to have relevant quotes that describe the adjective they are tied to. The core idea is to help users tie down an appropriate mood for
their work by using the quote as a basis.

Features:
Our app has a feature to search for random quotes by categories. The search can be done either by selecting a category from a drop-down list or by entering an 
adjective manually in the search bar. If no match is found (from manually entered input), the screen will display that there is no match found. Once an existing category
is selected, a corresponding random quote is displayed with arrows that direct to different quotes from the same category. There is a “Randomize” button at the bottom of
each quote, and it directs users to random quotes from a random category.

Data:
We used a modified CSV file of famous quotes we found online [1]. 

Tools:
We used Processing for frontend UI and GIMP for button creation. C++ was used for backend functionality, cleaning data, and recalling data.

Algorithms Implemented:
The first data structure that we used is a map using a string key and vector for the value. This allowed us to have the frontend software input the string, 
which is used to randomly choose a quote from that vector. The vector will hold a custom class that holds the person, quote, and other information which will be printed
as the output. The second data structure is an altered B+ tree. Specifically, a tree sorted in alphabetical order and each leaf is an author's name. 
This would also allow us to have a feature where you could access two other authors, the one above and below them in alphabetical order. Either way, the information 
will be represented as the plain text, with the quote followed by the relevant information under it. The text box will have different colors dependent on the adjective
tied to the quote to reflect the mood.

 Distribution of Responsibility and Roles: 
·        Dany Rashwan: Frontend, UI, Integrating backend with frontend.
·        Robert Kilkenny: Backend, Cleaning database, searching database
·        Jane Seo: Visuals Prototype 

Changes Made After Proposal: 
In the proposal, we had two options to search for quotes: search by author and search by category. After the proposal, we decided to remove the search by author 
function in order to compare time complexities on search by categories for both B+ Trees and Maps implementations. Also, we were planning on adding background colors 
to each quote according to their category but disregarded the background colors as it is not essential. 


Big O Worst Time Complexity:
Q is the number of quotes. C is the number of categories.
For both B+ Trees and Maps implementations, the time complexity is O(Q * C). The program first goes through every quote and stores the quote and author by each category
that is tied to them. It loops through Q times and stores C times (one per category). Therefore, the time complexity is O(Q * C). When the program searches for the data 
in each structure, it finds the category in O(log C) time since they are an ordered map and a B+ Tree. Then they print every quote attached to that category into output.txt,
which takes O(Q) time. Thus, this adds up to O(Q * C). 


Reflection:
The overall experience for the project as a group was great as Dany and Robert went above and beyond to complete this project. One of the challenges we faced was that
Jane was either in a different country or across the country which caused the time difference. So sometimes she wasn’t able to join the chat or meeting on time.
If we were to start once again as a group, we would use github to load the code and let other members add or modify the code so that everyone can join in the coding
part of the project. 

Comment on What Each Members Learned Through This Process:
·        Dany Rashwan: Overall this has been a great experience. It was interesting to connect Java and C++ for the front and back end respectively. 
                        It was my first time doing so and doing it with this team definitely aided my experience and taught me a lot.
·        Robert Kilkenny: 
·        Jane Seo: I learned that I need to be more actively involved in group projects. For the technical part, I learned how the front end and back end are combined. 

References
https://www.kaggle.com/datasets/manann/quotes-500k
