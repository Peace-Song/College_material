import React, { Component } from 'react';
import { BrowserRouter, Route, Redirect, Switch, browserHistory } from 'react-router-dom';
import './App.css';
import Login from './components/Login';
import ArticleList from './components/ArticleList';
import ArticleCreate from './components/ArticleCreate';
import ArticleDetail from './components/ArticleDetail';

class App extends Component{
  state = {
    isLoggedIn: false,
    isCreatingArticle: false,
    user: {
      email: "",
      password: ""
    },
    articleList: [],
    commentList: []
  }

  id = 0;

  onLogIn = (event) => {
    this.setState({
      ...this.state,
      isLoggedIn: true,
      isCreatingArticle: false,
      user: {
        email: event.email,
        password: event.password
      }
    });

    console.log("App received email = " + event.email);
    console.log("App received password = " + event.password);
    console.log("Logged in as " + event.email)
  }

  onLogOut = () => {
    this.setState({
      ...this.state,
      isLoggedIn: false,
      isCreatingArticle: false,
      user: {
        email: "",
        password: ""
      }
    });

    console.log("Successfully logged out");
  }

  // data == article
  onCreateArticle = (data) => {
    this.setState({
      ...this.state,
      isCreatingArticle: true
    });

    console.log("Started creating an article");
  }

  onFinishedCreateArticle = (data) => {
    this.setState({
      ...this.state,
      articleList: this.state.articleList.concat({
        author: data.author,
        id: this.id++,
        title: data.title,
        content: data.content
      })
    });

    console.log("Finished creating an article");
  }

  onAbortedCreateArticle = () => {
    this.setState({
      ...this.state,
      isCreatingArticle: false
    });
  }

  render(){
    this.id++;
    let redirectionToLogIn = null;
    if(!this.state.isLoggedIn) redirectionToLogIn = <Redirect to="/login" />;

    return (
      <BrowserRouter >
        <div className="App">
          <Switch>
            <Route 
              path="/login" 
              exact 
              render={() => <Login 
                onLogIn={this.onLogIn}
                onLogOut={this.onLogOut}
                isLoggedIn={this.state.isLoggedIn} 
              />} 
            />

            {redirectionToLogIn}

            <Route
              path="/articles"
              exact
              render={() => <ArticleList 
                onLogOut={this.onLogOut}
                isLoggedIn={this.state.isLoggedIn}
                onCreateArticle={this.onCreateArticle}
                isCreatingArticle={this.state.isCreatingArticle}
              />} 
            />

            <Route
              path="/articles/create"
              exact
              render={() => <ArticleCreate
                onLogOut={this.onLogOut}
                isLoggedIn={this.state.isLoggedIn}
                onFinishedCreateArticle={this.onFinishedCreateArticle}
                isCreatingArticle={this.state.isCreatingArticle}
                onAbortedCreateArticle={this.onAbortedCreateArticle}
                author={this.state.user.email}
                id={this.id}
              />}
            />

            <Route
              path="/articles/:id"
              exact
              render={() => <ArticleDetail
                onLogout={this.onLogout}
                isLoggedIn={this.state.isLoggedIn}
                articleList={this.state.articleList}
                author={this.state.user.email}
              />}
            />

          </Switch>
        </div>
      </BrowserRouter>
    );
  }

}

export default App;
