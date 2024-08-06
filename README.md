# Digital-Music-Store-Analysis
Using SQL, I analyzed a group of datasets that form an online digital music store. After asking and answering preliminary questions, I dug deeper to understand the store’s business performance and key factors for growth and robust decision making. 

## Database Setup 
In order to analyze the digital mustic store database, I used PostgreSQL, one of many SQL-supported database management systems (DBMS) along with pgadmin4, the interface of the overarching database. This was the installed engine and I used this system to practice SQL. Others can be utilized as well. Here's what was done to get my working environment ready: 
  1. Downloaded .csv files to my computer that would serve as database tables
  2. Created and named a new database in PostgreSQL 
  3. Generated tables to match the music store's schema (see below) 
  4. Imported the .csv files in the newly formed database 

## Schema Blueprint 
By understanding the relationships between tables and connecting primary/foreign keys, data in different locations will become more easily accessible. 

<img width="594" alt="schema_diagram" src="https://github.com/user-attachments/assets/47c0f09b-9232-4896-ba32-354cb3d44234">

## Inspiration & Guide
Below are a few Youtube videos that helped me progress my SQL skills and broaden my understanding of different query types. 
  1. https://www.youtube.com/watch?v=LJC8277LONg
  2. https://www.youtube.com/watch?v=0rB_memC-dA
  3. https://www.youtube.com/watch?v=VFIuIjswMKM

## Objective
The goal is to answer questions by manipulating data in various tables and intepret the digital music store's business through the firm's employees, customers, countries, artists, their tracks and much more!  

## Questions (a few)
  1. What is the most popular genre of music? 
  2. What is the popular song?
  3. Who is the most popular artist?
  4. Who is the most senior employee? 
  5. Which customer spent the most money? 

## Answers (a few)
  1. Rock is the most popular genre of music. 
  2. War Pigs is the most popular song. 
  3. Queen is the most popular artist. 
  4. Mohan Madan is the most senior employee. 
  5. R. Madhav spent the most money on music. 

## Findings & Insights
There is much to make of the music store's global business. 
  1. The USA has the highest total invoice amount and has made the most money from customers purchasing its music.
     - It might've been a good idea to check where majority of employees and customers are from to see if there is a connection. If this music store is based in the USA, that could make a lot of sense.
     - Nonetheless, we see that the music store's revenue is heavily tied to North America where USA and Canada are its top sales generating nations. 
  2. Rock is the most popular genre across majority of customers from various countries.
     - It might've been a good idea to see the average birthdate of customers in case there is a correlation of a similiar age group liking similiar genres.
     - It is interesting to see that Rock song lengths are middle of the pack while Rock and Roll songs have the shortest time in milliseconds. I don't listen to either genres but there could be an overlap. 
  3. Price is not a factor that influences a customer's decision to buy or not to buy a track from the music store.
     - All songs are sold at a standard unit price of ~ $0.99. It would be cool to understand the revenue breakdown of a song between the many parties in the music industry: artist, composer, label, store, etc. 
     - What if the music store priced more popular songs from common genres at a higher price? There is a chance that if demand is inelastic (customer buying habits stay the same), increase in revenue is likely.   

## Additional Investigation
Based on what is known from our analysis, this is what I would explore further. 
  1. Perform city analysis: 
     - Country analysis was done which gave us a good breakdown of customers and genres.
     - City analysis could also provide information on customer traits and preferences on a more specific level. Factors like age and employment may tell us more regarding the unique customer. 
  2. Figure out diverse buying options for customers: 
     - How can the music store drive revenue at a larger, more efficient scale?
     - Tracks look like they are only being bought individually. See if the music store is open to bulk options such as buying an artist's entire album at a discounted price - maybe more customers get in on this.


