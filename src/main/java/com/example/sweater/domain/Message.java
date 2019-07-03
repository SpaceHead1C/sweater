package com.example.sweater.domain;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
public class Message {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private String text;
    private String tag;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    public Message() {} // required by Spring

    public Message(String text, String tag, User author) {
        this.author = author;
        this.text = text;
        this.tag = tag;
    }

    public String getAuthorName() {
        return author != null ? author.getUsername() : "<none>";
    }

    /**
     * Getters и Setters автоматически сгенерирует lombok
     */
}
