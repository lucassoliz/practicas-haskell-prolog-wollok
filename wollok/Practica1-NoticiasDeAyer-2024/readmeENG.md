# Yesterday's News, Extra! Extra!

A major multimedia network wants to modernize its digital newspaper. Following a review, the following requirements have emerged which must be implemented using the **Object-Oriented Paradigm**.

![wollok_resto_banner](https://images.impresa.pt/sicnot/2021-09-23-SIMPSONS.jpg-95326601-2)
---

## Point 1) Chocolate for the News (4 points)

### Basic Article Structure

Every news item or article must have a publication date, the person who publishes it (a Journalist), its degree of importance measured in a number from 1 to 10, the title, and the body of the news. There are three styles of news or article:

- Common articles can have links to other news.
- Some news items are actually **covert advertising** (known in journalistic jargon as a “chivo”). They promote a product, and we know the **money paid** for the article to be published.
- **Reports** are made about someone (e.g., “María Becerra” or “Los Auténticos Decadentes”).
- Finally, there is a **Coverage**, which also includes a series of related news items.

### "Hot News" Criteria (Noticia Copada)

We want to know if a news item is considered **Hot News**. In general, it must be an **important** news item (its degree of importance must be $\ge 8$) and have been published **less than 3 days ago**.

Additionally, it must meet the specific condition for its style:

- For **Common Articles**, it must have at least **2 links** to other news.
- For **Chivos**, more than **2M** must have been paid.
- **Reports** are hot news if the person interviewed has an **odd number of letters** in their name (e.g., “Los Auténticos Decadentes” has 25 letters, making it a hot report).
- **Coverages** are hot news if **all** related news items are hot news.

---

## Point 2) The Pelican Report (3 points)

As mentioned, news items or articles are published by **journalists**, whose entry date and preferences we know:

- Some want to publish **Hot News**.
- Others want to publish **sensationalist** news: this means it must contain the word **“espectacular”**, **“increíble”**, or **“grandioso”** in the title, and in the case of reports, they must **also be about “Dibu Martínez”**.
- There are the **Slackers** (vagos), who only want to publish **Chivos** or news items whose body has **fewer than 100 words**.
- And there is **José De Zer**, who enjoys publishing news items whose title **begins with the letter "T"**.

---

## Point 3) Front Page (3 points)

We want to publish a new news item, for which:

- A journalist cannot publish **more than 2 news items they do not prefer** per day. For example: if a journalist prefers hot news, they can only publish 2 non-hot news items that day.

A well-written news item must have:
- A title with **2 or more words**.
- It must have a **body/development**.

We want this functionality to incorporate the validations required by the business, and in case of failure to meet any rule, define how the system should respond.

---

## Point 4) The Fourth Estate (2 points)

We want to be able to determine which **recent journalists** published a news item in the **last week**. **Recent Journalists** are those who joined the multimedia network **one year ago or less**. Explicit consideration must be given to **delegation** and the implementation of **declarative solutions**.

---

## Final Grade

| Score | Grade |
| :--- | :--- |
| 11.50 to 12 | 10 |
| 10 to 11.50 | 9 |
| 9 a 10 | 8 |
| 8 a 9 | 7 |
| 7 a 8 | 6 |
| 6 a 7 | Review |
| < 6 | Fail |