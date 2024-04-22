---
layout: single
title: Markets Uncertainty vs. Volatility
categories:
 - Economics & Finance
 - Uncertainty
 - Mathematics
 - Time Series Analysis
 - MATLAB
tags:
drafted_at: 2024-04-18 14:00:35 +0800
date:
last_modified_at0:
last_modified_at:
---



Recently I've been reading Morgan Housel's[^1] book *The Psychology of Money: Timeless lessons on wealth, greed, and happiness*[^2]. In the fifteenth chapter "Nothing's Free: Everything has a price, but not all prices appear on labels", Housel believes that investors should view market volatility and uncertainty as a "fee" (a price worth paying to get something nice in exchange) rather than a "fine" (a penalty should avoid). A relatively complete part of his views shows as follows:

<br>

... but thinking of **market volatility** as a fee rather than a fine is an important part of developing the kind of mindset that lets you stick around long enough for investing gains to work in your favor.

Few investors have the disposition to say, "I'm actually fine if I lose 20% of my money." This is doubly true for new investors who have never experienced a 20% decline.

But if you view **volatility** as a fee, things looks different.

Disneyland tickets cost \$100. But you get an awesome day with your kids you'll never forget. Last year more than 18 million people thought that fee was worth paying. Few felt the \$100 was a punishment or a fine. The worthwhile tradeoff of fees is obvious when it's clear you're paying one.

Same with investing, where volatility is almost always a fee, not a fine.

Market are never free and never will be. They demand you pay a price, like any other product. You're not forced to pay this fee, just like you're not forced to go to Disneyland. You can go to the local county fair where tickets might be \$10, or stay home for free. You might still have a good time. But you'll usually get what you pay for. Same with markets. The **volatility/uncertainty** fee—the price of returns—is the cost of admission to get returns greater than low-fee parks like cash and bonds.

The trick is convincing yourself that the market's fee is worth it. That's the only way to properly deal with **volatility** and **uncertainty**—not just putting up with it, but realizing that it's an admission fee worth paying.

There's no guarantee that it will be. Sometimes it rains at Disneyland.

But if you view the admission fee as a fine, you'll never enjoy the magic.

Find the price, then pay it.

<br>

Anyway, it's really a novel perspective and I am convinced. I have a new understanding about market volatility and uncertainty.

On the other hand, Few days ago, when I wrote the blog "Fetch S&P 500 Price Index (or Other Available Series) from FRED (Federal Reserve Economic Data) Server in MATLAB"[^3], I found an FRED blog by chance, "Measuring uncertainty and volatility with FRED data"[^4]. In this blog, the author points out the nuance between the notions of market "uncertainty" and "volatility":

<br>

Uncertainty and volatility are closely related but distinct concepts. People are uncertain if they lack confidence in their knowledge of the state of the world or future events. News is more likely to change the views of people with high **uncertainty**. In financial markets, changing views is associated with changing asset prices, so **volatility** is ex post (after the fact) measure of **uncertainty**. 

Uncertainty and volatility are carefully watched variables because of their relation to financial crises. During such periods, uncertainty often rises to high levels as the prices of risky assets, such as stocks, tend to fall. This produces a short-term, negative relation between uncertainty and returns.

FRED has a number of series that are related to uncertainty and/or volatility, some of which are derived from options data. One of the most frequently used such series is the Chicago Board of Options Exchange (CBOE) Volatility Index, or VIX. This options-derived series predicts one-month-ahead volatility on the CBOE S&P 500 futures contract.

<br>

However, I am really confused, because as the blog pointed out, market volatility is a kind of **ex post** measure of market uncertainty; on the other hand, the blog takes CBOE Volatility Index, which is for predicting one-month-ahead 



ex-ante



interactive and editable graphs to showing

<br>

# Volatility (finance)

As described in Wikipedia[^9], In finance, **volatility** (usually denoted by "$\sigma$") is the degree of variation of a trading price series over time, usually measured by the standard deviation of logarithmic returns. Implied volatility looks forward in time, being derived from the market price of a market-traded derivative (in particular, an option).

Volatility as described here refers to the actual volatility, more specifically:

- **Actual current volatility** of a financial instrument for a specified period (for example 30 days or 90 days), based on historical prices over the specified period with the last observation the most recent price.
- **Actual historical volatility**: the volatility of a financial instrument over a specified period but with the last observation on a date in the past. [near synonymous is **realized volatility**, the square root of the realized variance, in turn calculated using the sum of squared returns divided by the number of observations.]
- **Actual future volatility**: the volatility of a financial instrument over a specified period starting at the current time and ending at a future date (normally the expiry date of an option).

For implied volatility

- **historical implied volatility**: the implied volatility observed from historical prices of the financial instrument (normally options).
- **current implied volatility**: the implied volatility observed from current prices of the financial instrument.
- **future implied volatility**: the implied volatility observed from future prices of the financial instrument.





==there are many measures (or indexes) to indicate the volatility==





<br>

# Chicago Board of Options Exchange Volatility Index

Chicago Board of Options Exchange Volatility Index (CBOE Volatility Index, or VIX)[^6][^7] is a popular measure of the stock market's expectation of volatility based on S&P 500 index options. It is calculated and disseminated on a real-time basis by the CBOE (available at Google Finance[^8]), and also known as **fear index** or **fear gauge**.











<br>

# Other expressions

"Volatility can be seen as a measure of uncertainty."[^5]







# Conclusion

There so many players in the markets participating in the game, and the "future (expected) price" is more common. So, it is possible to obtain a future price in the market. This is very different from my research area, electrical engineering, more like something like hard science.

<br>

# References

[^1]: [Morgan Housel](https://www.morganhousel.com/).
[^2]: The Psychology of Money: Timeless lessons on wealth, greed, and happiness, Morgan Housel, available at: [The Psychology of Money: Timeless Lessons on Wealth, Greed, and Happiness](https://pdflake.com/wp-content/uploads/2021/08/The-Psychology-of-Money-PDF-Book-By-Morgan-Housel.pdf).
[^3]: [Fetch S&P 500 Price Index (or Other Available Series) from FRED (Federal Reserve Economic Data) Server in MATLAB - What a starry night~](https://helloworld-1017.github.io/2024-04-17/13-58-11.html).
[^4]: [Measuring uncertainty and volatility with FRED data \| FRED Blog](https://fredblog.stlouisfed.org/2021/06/measuring-uncertainty-and-volatility-with-fred-data/?utm_source=series_page&utm_medium=related_content&utm_term=related_resources&utm_campaign=fredblog).
[^5]: [Uncertainty and unknowns: the main causes of volatility](https://www.sunlifeglobalinvestments.com/en/insights/investor-education/understanding-market-volatility/uncertainty-and-unknowns-the-main-causes-of-volatility/).
[^6]: [VIX - Wikipedia](https://en.wikipedia.org/wiki/VIX).
[^7]: [CBOE Volatility Index (VIX): What Does It Measure in Investing?](https://www.investopedia.com/terms/v/vix.asp).

[^8]: [VIX 18.71 (▲3.94%) VIX指数 \| Google 财经](https://www.google.com/finance/quote/VIX:INDEXCBOE).
[^9]: [Volatility (finance) - Wikipedia](https://en.wikipedia.org/wiki/Volatility_(finance))



[MATLAB `corr`: Linear or rank correlation - MathWorks](https://ww2.mathworks.cn/help/stats/corr.html).

