package com.example.sweater.controller;

import com.example.sweater.domain.Message;
import com.example.sweater.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;

    @GetMapping("/")
    public String greeting(
            @RequestParam(name="name", required=false, defaultValue="World") String name,
            Map<String, Object> model
    ) {
        model.put("name", name);
        return "greeting";
    }

    @GetMapping("/main")
    public String main(Map<String, Object> model) {
        Iterable<Message> mesages = messageRepo.findAll();

        model.put("messages", mesages);

        return "main";
    }

    @PostMapping("/main")
    public String add(@RequestParam String text, @RequestParam String tag, Map<String, Object> model) {
        messageRepo.save(new Message(text, tag));

        model.put("messages", messageRepo.findAll());

        return "main";
    }

    @PostMapping("/filter")
    public String filter(@RequestParam String filter, Map<String, Object> model) {
        Iterable<Message> messages;

        messages = filter == null || filter.isEmpty() ? messageRepo.findAll() : messageRepo.findByTag(filter);

        model.put("messages", messages);

        return "main";
    }
}