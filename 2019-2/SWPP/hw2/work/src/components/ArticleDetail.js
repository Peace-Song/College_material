import React, { Component } from 'react';
import { BrowserRouter, Route, Redirect, Switch } from 'react-router-dom';
import ArticleCreate from './ArticleCreate';

class ArticleDetail extends Component{
    state = {
        backToList: false,
        comment: {
            commentAuthor: this.props.author,
            commentContent: "",
            commentId: 0,
            idOfComment: 0
        }
    }

    handleBack = () => {
        this.setState({
            ...this.state,
            backToList: true
        });
    }

    handleChangeContent = (event) => {
        this.setState({
            ...this.state,
            commentContent: event.target.value
        });
    }

    handleCommentPost = () => {
        
    }

    render(){
        let articleList = this.props.articleList;
        let lastArticle = articleList[articleList.length-1];

        if(this.state.backToList){
            this.setState({
                ...this.state,
                backToList: false
            });
            return(<Redirect to="/articles" />);
        }

        return(
            <div>
                ArticleDetail
                <div>
                    <h1 id="article-title">{lastArticle.title}</h1>
                    <p  id="article-content">{lastArticle.content}</p>
                    <p  id="article-author">Author: {lastArticle.author}</p>
                </div>
                <div>
                    <input 
                        id="new-comment-content-input"
                        name="commentContent"
                        placeholder="Your comment here"
                        onChange={this.handleChangeContent}
                        value={this.state.comment.commentContent}
                    />
                    <button
                        id="confirm-create-comment-button"
                        onClick={this.handleCommentPost}
                    >Post comment</button>
                    <button
                        id="edit-comment-button"
                    >Edit comment</button>
                    <button
                        id="delete-comment-button"
                    >Delete comment</button>
                </div>
                <div>
                    <button
                        id="edit-article-button"
                    >Edit article</button>
                    <button
                        id="delete-article-button"
                    >Delete article</button>
                </div>  
                <div>   
                    <button
                        id="back-detail-article-button"
                        onClick={this.handleBack}
                    >Back to the list</button>
                </div>
            </div>
        );
    }
}

export default ArticleDetail;
