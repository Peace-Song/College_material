import React, { Component } from 'react';
import { BrowserRouter, Route, Redirect, Switch } from 'react-router-dom';
import ArticleDetail from './ArticleDetail';
import ArticleCreate from './ArticleCreate';

class ArticleList extends Component{

    
    
    createArticle = () => {
        this.props.onCreateArticle(true);
    }

    //TODO: think how to set createArticle to false when redirected to create
    render(){
        console.log("ArticleList.render() called");


        let redirectToLogIn = !this.props.isLoggedIn ? 
            <Redirect to="/login" /> : null;
        let redirectToCreateArticle = this.props.isCreatingArticle ? 
            <Redirect to="/articles/create" /> : null;
        
        return (
            <div>
                <button
                    id="logout-button"
                    onClick={this.props.onLogOut}
                >Log out</button>
                {redirectToLogIn}

                <button
                    id="create-article-button"
                    onClick={this.createArticle}
                >Create an article</button>
                {redirectToCreateArticle}
            </div>
        );
    }
}

export default ArticleList;

