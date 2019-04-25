---
layout: post
title: Testing React Hooks with React Testing Library
date: 04-04-2019 20:44:10
categories: [code]
---
I recently re-wrote a small Announcement Bar component at work using React Hooks. After finishing rewriting it, my manager brought it to my attention that the tests that were previously written for the component were all failing.

Great!

What a good opportunity to dive down the rabbit-hole of how to test React Hooks components!

### Introduction
After a quick google search, I found Yomi's [article](https://blog.logrocket.com/a-quick-guide-to-testing-react-hooks-fa584c415407) on LogRocket's blog about testing React Hooks. In it, he attempts to use Jest and Enzyme for testing but quickly realizes that his tests throw a `Hooks can only be called inside the body of a function component.` error as reported in this [issue](https://github.com/airbnb/enzyme/issues/1938) on Github.

To get around this problem, he introduced me to Kent C. Dodds's [React Testing Library](https://github.com/kentcdodds/react-testing-library).

_Sidebar: Kent wrote an article called [React Hooks: What's going to happen to my tests?](https://kentcdodds.com/blog/react-hooks-whats-going-to-happen-to-my-tests) earlier this year that is worth a read._

I had heard another engineer at Losant talk about the library before, but never devoted any time to installing it and trying it out myself, so I knew I was on the right track. After adding react-testing-library as a dev-dependency, I started writing some tests.

The pattern that I followed was pretty straight forward:
1. Render the component
2. Query the component by some identifier (text, class name, etc)
3. Perform some action on it
4. Test that something happened as expected

### Import
This is pretty straightforward, just import the methods we are going to use from RTL.

```
import { render, act, fireEvent, cleanup, wait } from 'react-testing-library';
```

### Render
Unlike Enzyme, which has multiple different ways of rendering a component like shallow and mount, RTL just has a simple `render` method. It works just like Enzyme's functions though! Just pass the component in like you would render it normally as the first argument:

```
const { getByText, queryByText, asFragment } = render(
  <AnnouncementBarWithRouter 
      currentUser={sandboxOwnerInGoodStanding} 
      whiteLabel={losantWhiteLabel} 
      owner={orgAsAdminUnpaid} 
      lastSeenBlogPostTime={12345} />
);
```

Note: depending on whether or not your component fetches data or does other async operations, you may need to wrap your render function in an `act()` function and then wait for those operations to finish:

```
await act(async () => {
      await wait(() => expect(queryByTestId('announcement-bar')).toBeNull()); // wait for promises to finish resolving
    });
});
```


### Query
Now we can query the rendered component using the [query mehtods](https://testing-library.com/docs/dom-testing-library/api-queries) we deconstructed from the render call above. RTL comes with getBy*, queryBy*, and findBy* methods.

```
expect(getByText('Platform Update Roundup 2018')).toBeInTheDocument();
expect(queryByText('Platform Update Roundup 2017')).toBeNull();
expect(asFragment()).toMatchSnapshot();
```
Migrating from Enzyme, I thought this was rather confusing. I was used to rendering a wrapper and then performing a query on it to get the content I wanted. These deconstructed query functions are performed _on_ the container that was rendered before. This could be somewhat problematic if you are testing multiple renders within a single test, but this is actually a good thing because you shouldn't be doing that in the first place!

One important thing in the code snippet above is the difference between `getByText` and `queryByText`. getByText expects the text snippet to be there while queryByText may return null. Therefore, when checking for the absence of something, utilize queryBy functions.

Also, the `isFragment` allows us to utilize Jest snapshots if that's something your team does.

### Fire Events
It's important to test that certain events will perform the behavior that is expected. To fire events, use the fireEvent function that was imported from RTL.

```
// dismiss the notification
fireEvent.click(getByTestId('dismiss'));

// make sure it actually went away
const BlogNotification = queryByText('Platform Update Roundup 2018');
expect(BlogNotification).toBeNull();

// check that localStorage was called with the correct arguments
expect(global.localStorage.setItem).toBeCalledTimes(1);
expect(global.localStorage.setItem).toBeCalledWith(`lastBlogSeen-${sandboxOwnerInGoodStanding.item.id}`, new Date().getTime());
```

### Conclusion
I really enjoyed React Testing Library's straight forward way of testing components. It took a lot of the weird technical complexity out of writing tests. Just render the component, perform an action on it, and check to makes sure the results are what you expect!